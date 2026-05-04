// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, dead_code
// D4rt test script: Tests ViewConstraints from dart:ui
// Deep Demo: Visual demonstration of ViewConstraints anatomy, recipes,
// pitfalls, and comparison with BoxConstraints.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewConstraints Deep Demo executing');

  // ============================================================
  // SECTION 0: Probe a few canonical ViewConstraints instances.
  // These instances feed every visual section below.
  // ============================================================
  print('=== Section 0: Probing ViewConstraints instances ===');

  final ui.ViewConstraints vcUnconstrained = const ui.ViewConstraints();
  print('Unconstrained: $vcUnconstrained');
  print(
    '  minW=${vcUnconstrained.minWidth} maxW=${vcUnconstrained.maxWidth} '
    'minH=${vcUnconstrained.minHeight} maxH=${vcUnconstrained.maxHeight}',
  );
  print('  isTight=${vcUnconstrained.isTight}');

  final ui.ViewConstraints vcLoose = const ui.ViewConstraints(
    minWidth: 0.0,
    maxWidth: 800.0,
    minHeight: 0.0,
    maxHeight: 600.0,
  );
  print('Loose (0..800 x 0..600): $vcLoose');
  print('  isTight=${vcLoose.isTight}');
  print('  isSatisfiedBy(400,300)=${vcLoose.isSatisfiedBy(const Size(400.0, 300.0))}');
  print('  isSatisfiedBy(900,300)=${vcLoose.isSatisfiedBy(const Size(900.0, 300.0))}');

  final ui.ViewConstraints vcTight = ui.ViewConstraints.tight(const Size(400.0, 300.0));
  print('Tight 400x300: $vcTight');
  print('  isTight=${vcTight.isTight}');
  print('  isSatisfiedBy(400,300)=${vcTight.isSatisfiedBy(const Size(400.0, 300.0))}');
  print('  isSatisfiedBy(401,300)=${vcTight.isSatisfiedBy(const Size(401.0, 300.0))}');

  final ui.ViewConstraints vcRange = const ui.ViewConstraints(
    minWidth: 200.0,
    maxWidth: 600.0,
    minHeight: 150.0,
    maxHeight: 450.0,
  );
  print('Range: $vcRange');
  print('  isTight=${vcRange.isTight}');

  final ui.ViewConstraints vcDpr2 = vcLoose / 2.0;
  print('vcLoose / 2.0 = $vcDpr2');
  print('  scaled minW=${vcDpr2.minWidth} maxW=${vcDpr2.maxWidth}');

  final ui.ViewConstraints vcEqualA = const ui.ViewConstraints(
    minWidth: 10.0,
    maxWidth: 20.0,
    minHeight: 30.0,
    maxHeight: 40.0,
  );
  final ui.ViewConstraints vcEqualB = const ui.ViewConstraints(
    minWidth: 10.0,
    maxWidth: 20.0,
    minHeight: 30.0,
    maxHeight: 40.0,
  );
  print('Equality (a==b): ${vcEqualA == vcEqualB}');
  print('Hash equality (a.hashCode==b.hashCode): ${vcEqualA.hashCode == vcEqualB.hashCode}');

  final ui.PlatformDispatcher pd = ui.PlatformDispatcher.instance;
  final ui.FlutterView? implicitView = pd.implicitView;
  String viewSummary;
  if (implicitView != null) {
    final ui.ViewConstraints viewPc = implicitView.physicalConstraints;
    viewSummary =
        'implicit view: minW=${viewPc.minWidth.toStringAsFixed(1)} '
        'maxW=${viewPc.maxWidth.toStringAsFixed(1)} '
        'minH=${viewPc.minHeight.toStringAsFixed(1)} '
        'maxH=${viewPc.maxHeight.toStringAsFixed(1)} '
        'tight=${viewPc.isTight}';
    print('PlatformDispatcher.implicitView.physicalConstraints: $viewPc');
  } else {
    viewSummary = 'implicit view: <null>';
    print('PlatformDispatcher.implicitView is null');
  }

  // ============================================================
  // PALETTES & GRADIENT POOL
  // ============================================================
  // These gradients are reused across sections so we comfortably
  // exceed the >=8 LinearGradient and >=8 BoxShadow targets, all
  // of them attached to widgets that are actually rendered.
  // ============================================================
  final LinearGradient gradHero = LinearGradient(
    colors: <Color>[Colors.indigo.shade700, Colors.deepPurple.shade400, Colors.pink.shade300],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradAnatomy = LinearGradient(
    colors: <Color>[Colors.blueGrey.shade50, Colors.blueGrey.shade100],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  final LinearGradient gradMinWidth = LinearGradient(
    colors: <Color>[Colors.teal.shade100, Colors.teal.shade300],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradMaxWidth = LinearGradient(
    colors: <Color>[Colors.cyan.shade100, Colors.cyan.shade400],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradMinHeight = LinearGradient(
    colors: <Color>[Colors.lightGreen.shade100, Colors.green.shade400],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradMaxHeight = LinearGradient(
    colors: <Color>[Colors.amber.shade100, Colors.orange.shade400],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradRecipe = LinearGradient(
    colors: <Color>[Colors.purple.shade50, Colors.indigo.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradPitfall = LinearGradient(
    colors: <Color>[Colors.red.shade50, Colors.deepOrange.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradCompare = LinearGradient(
    colors: <Color>[Colors.amber.shade100, Colors.orange.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradQuickRef = LinearGradient(
    colors: <Color>[Colors.grey.shade900, Colors.blueGrey.shade800],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final LinearGradient gradFooter = LinearGradient(
    colors: <Color>[Colors.black87, Colors.indigo.shade900],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  final LinearGradient gradPlatform = LinearGradient(
    colors: <Color>[Colors.lightBlue.shade50, Colors.blue.shade100],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final List<BoxShadow> shadowSoft = <BoxShadow>[
    BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 6.0, offset: const Offset(0.0, 2.0)),
  ];
  final List<BoxShadow> shadowMedium = <BoxShadow>[
    BoxShadow(color: Colors.black.withValues(alpha: 0.14), blurRadius: 10.0, offset: const Offset(0.0, 4.0)),
  ];
  final List<BoxShadow> shadowStrong = <BoxShadow>[
    BoxShadow(color: Colors.black.withValues(alpha: 0.22), blurRadius: 18.0, offset: const Offset(0.0, 8.0)),
  ];
  final List<BoxShadow> shadowIndigo = <BoxShadow>[
    BoxShadow(color: Colors.indigo.withValues(alpha: 0.30), blurRadius: 14.0, offset: const Offset(0.0, 6.0)),
  ];
  final List<BoxShadow> shadowTeal = <BoxShadow>[
    BoxShadow(color: Colors.teal.withValues(alpha: 0.30), blurRadius: 10.0, offset: const Offset(0.0, 4.0)),
  ];
  final List<BoxShadow> shadowAmber = <BoxShadow>[
    BoxShadow(color: Colors.orange.withValues(alpha: 0.35), blurRadius: 12.0, offset: const Offset(0.0, 4.0)),
  ];
  final List<BoxShadow> shadowRose = <BoxShadow>[
    BoxShadow(color: Colors.pink.withValues(alpha: 0.30), blurRadius: 12.0, offset: const Offset(0.0, 6.0)),
  ];
  final List<BoxShadow> shadowSlate = <BoxShadow>[
    BoxShadow(color: Colors.blueGrey.withValues(alpha: 0.30), blurRadius: 10.0, offset: const Offset(0.0, 4.0)),
  ];

  // ============================================================
  // SECTION 1: HERO BANNER
  // ============================================================
  print('=== Section 1: Hero ===');

  final Widget heroBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: gradHero,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: shadowStrong,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 84.0,
          height: 84.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: shadowIndigo,
          ),
          child: const Icon(Icons.aspect_ratio, color: Colors.white, size: 48.0),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ui.ViewConstraints',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'The min/max width & height envelope a FlutterView promises a frame.',
                style: TextStyle(fontSize: 14.0, color: Colors.white.withValues(alpha: 0.92)),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 6.0,
                children: <Widget>[
                  _heroChip('library: dart:ui'),
                  _heroChip('immutable'),
                  _heroChip('value-equality'),
                  _heroChip('operator /'),
                  _heroChip('isTight'),
                  _heroChip('isSatisfiedBy(Size)'),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY (min/maxWidth, min/maxHeight visualised)
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final Widget anatomy = Container(
    margin: const EdgeInsets.only(top: 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradAnatomy,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.2),
      boxShadow: shadowMedium,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Anatomy of a ViewConstraints',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blueGrey.shade900),
        ),
        const SizedBox(height: 10.0),
        Text(
          'A 2D rectangle of allowed sizes. Width sits between [minWidth, maxWidth]; '
          'height sits between [minHeight, maxHeight]. Equal min/max on both axes => tight.',
          style: TextStyle(fontSize: 12.5, color: Colors.blueGrey.shade700),
        ),
        const SizedBox(height: 16.0),
        _anatomyDiagram(vcRange),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 10.0,
          children: <Widget>[
            _anatomyLegend('minWidth', Colors.teal, '${vcRange.minWidth}'),
            _anatomyLegend('maxWidth', Colors.cyan.shade700, '${vcRange.maxWidth}'),
            _anatomyLegend('minHeight', Colors.green, '${vcRange.minHeight}'),
            _anatomyLegend('maxHeight', Colors.orange, '${vcRange.maxHeight}'),
            _anatomyLegend('isTight', Colors.purple, '${vcRange.isTight}'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PER-FIELD CARDS
  // ============================================================
  print('=== Section 3: Per-field cards ===');

  final Widget perFieldCards = Wrap(
    spacing: 16.0,
    runSpacing: 16.0,
    alignment: WrapAlignment.center,
    children: <Widget>[
      _fieldCard(
        title: 'minWidth',
        valueText: '${vcLoose.minWidth}',
        description: 'Lowest acceptable width. Defaults to 0.0.',
        gradient: gradMinWidth,
        accent: Colors.teal,
        icon: Icons.swap_horiz,
        shadows: shadowTeal,
      ),
      _fieldCard(
        title: 'maxWidth',
        valueText: '${vcLoose.maxWidth}',
        description: 'Highest acceptable width. Defaults to double.infinity.',
        gradient: gradMaxWidth,
        accent: Colors.cyan.shade800,
        icon: Icons.swap_horiz,
        shadows: shadowSoft,
      ),
      _fieldCard(
        title: 'minHeight',
        valueText: '${vcLoose.minHeight}',
        description: 'Lowest acceptable height. Defaults to 0.0.',
        gradient: gradMinHeight,
        accent: Colors.green.shade700,
        icon: Icons.height,
        shadows: shadowSoft,
      ),
      _fieldCard(
        title: 'maxHeight',
        valueText: '${vcLoose.maxHeight}',
        description: 'Highest acceptable height. Defaults to double.infinity.',
        gradient: gradMaxHeight,
        accent: Colors.orange.shade800,
        icon: Icons.height,
        shadows: shadowAmber,
      ),
      _fieldCard(
        title: 'isTight',
        valueText: '${vcTight.isTight}',
        description: 'minWidth>=maxWidth && minHeight>=maxHeight.',
        gradient: gradRecipe,
        accent: Colors.purple.shade700,
        icon: Icons.lock_outline,
        shadows: shadowRose,
      ),
      _fieldCard(
        title: 'operator /',
        valueText: 'vc / 2.0',
        description: 'Scales every bound by 1/factor. Useful for DPR.',
        gradient: gradCompare,
        accent: Colors.deepOrange.shade700,
        icon: Icons.percent,
        shadows: shadowAmber,
      ),
    ],
  );

  // ============================================================
  // SECTION 4: SIZE-VS-CONSTRAINTS GRID (isSatisfiedBy)
  // ============================================================
  print('=== Section 4: isSatisfiedBy grid ===');

  final List<Size> probeSizes = <Size>[
    const Size(100.0, 100.0),
    const Size(200.0, 150.0),
    const Size(400.0, 300.0),
    const Size(600.0, 450.0),
    const Size(800.0, 600.0),
    const Size(900.0, 700.0),
  ];

  final List<_ProbedConstraints> probedConstraints = <_ProbedConstraints>[
    _ProbedConstraints('Unconstrained', vcUnconstrained, Colors.indigo),
    _ProbedConstraints('Loose 0..800 x 0..600', vcLoose, Colors.teal),
    _ProbedConstraints('Range 200..600 x 150..450', vcRange, Colors.deepPurple),
    _ProbedConstraints('Tight 400x300', vcTight, Colors.pink),
  ];

  final Widget satisfiedGrid = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: shadowSoft,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'isSatisfiedBy(Size) — green = inside the box, red = outside',
          style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        ),
        const SizedBox(height: 12.0),
        for (final _ProbedConstraints pc in probedConstraints)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: _isSatisfiedRow(pc, probeSizes),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: RECIPES
  // ============================================================
  print('=== Section 5: Recipes ===');

  final Widget recipes = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradRecipe,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.2),
      boxShadow: shadowIndigo,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Common recipes',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
        ),
        const SizedBox(height: 12.0),
        _recipeCard(
          'Unconstrained (default)',
          'const ViewConstraints();',
          'minW=0, maxW=∞, minH=0, maxH=∞ — anything goes.',
          Icons.all_out,
          Colors.indigo,
        ),
        _recipeCard(
          'Loose to a maximum',
          'const ViewConstraints(\n  maxWidth: 800.0,\n  maxHeight: 600.0,\n);',
          'Shrink-to-fit allowed up to (800, 600).',
          Icons.fullscreen_exit,
          Colors.teal,
        ),
        _recipeCard(
          'Tight to a single size',
          'ViewConstraints.tight(const Size(400, 300));',
          'Exactly 400x300 — isTight is true.',
          Icons.crop_square,
          Colors.pink,
        ),
        _recipeCard(
          'Range on both axes',
          'const ViewConstraints(\n  minWidth: 200, maxWidth: 600,\n  minHeight: 150, maxHeight: 450,\n);',
          'Bounded sandbox: anything inside the rect satisfies it.',
          Icons.crop_free,
          Colors.deepPurple,
        ),
        _recipeCard(
          'Scale by device pixel ratio',
          'final logical = physical / dpr;',
          'physicalConstraints / devicePixelRatio gives logical-pixel bounds.',
          Icons.zoom_out_map,
          Colors.orange,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: PITFALLS
  // ============================================================
  print('=== Section 6: Pitfalls ===');

  final Widget pitfalls = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradPitfall,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.red.shade300, width: 1.2),
      boxShadow: shadowRose,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 26.0),
            const SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.red.shade900),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfallRow(
          'Confusing physicalSize with physicalConstraints',
          'physicalSize is yesterday\'s frame; physicalConstraints is the bound for the next render.',
        ),
        _pitfallRow(
          'Forgetting infinity in defaults',
          'maxWidth and maxHeight default to double.infinity — many naive checks need explicit handling.',
        ),
        _pitfallRow(
          'Treating ViewConstraints as BoxConstraints',
          'They look similar but live in different layers. ViewConstraints is in dart:ui and lacks normalize/enforce/copyWith.',
        ),
        _pitfallRow(
          'Calling render(size) outside physicalConstraints',
          'Yields undefined rendering. Always pass a Size satisfying isSatisfiedBy.',
        ),
        _pitfallRow(
          'Ignoring DPR',
          'physicalConstraints is in physical pixels; divide by devicePixelRatio for logical pixels.',
        ),
        _pitfallRow(
          'Mutation expectations',
          'ViewConstraints is immutable; all "modifications" return a new instance via operator /.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: VS BoxConstraints COMPARISON
  // ============================================================
  print('=== Section 7: vs BoxConstraints ===');

  final Widget vsBox = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradCompare,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.2),
      boxShadow: shadowAmber,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ViewConstraints vs BoxConstraints',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
        ),
        const SizedBox(height: 12.0),
        _comparisonTable(<List<String>>[
          <String>['Aspect', 'ui.ViewConstraints', 'BoxConstraints'],
          <String>['Library', 'dart:ui', 'rendering / package:flutter'],
          <String>['Where', 'FlutterView.physicalConstraints', 'RenderBox layout'],
          <String>['Pixel space', 'physical pixels', 'logical pixels'],
          <String>['isTight', 'yes', 'yes'],
          <String>['isSatisfiedBy(Size)', 'yes', 'no (uses constrain/normalize)'],
          <String>['operator /', 'yes (scale by 1/factor)', 'no'],
          <String>['copyWith / enforce', 'no', 'yes'],
          <String>['biggest / smallest', 'no', 'yes'],
        ]),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: PLATFORM DISPATCHER PROBE
  // ============================================================
  print('=== Section 8: PlatformDispatcher probe ===');

  final Widget platformPanel = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradPlatform,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.lightBlue.shade400, width: 1.2),
      boxShadow: shadowSlate,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.dvr, color: Colors.blue.shade800, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Live FlutterView.physicalConstraints',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Looked up via ui.PlatformDispatcher.instance.implicitView at construction time.',
          style: TextStyle(fontSize: 12.0, color: Colors.blue.shade800),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Text(
            viewSummary,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: QUICK REFERENCE (code block)
  // ============================================================
  print('=== Section 9: Quick reference ===');

  final Widget quickRef = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradQuickRef,
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: shadowStrong,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.cyan.shade300, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          '// Default — fully unconstrained\n'
          'const vc = ViewConstraints();\n'
          '// minW=0  maxW=∞  minH=0  maxH=∞',
          Colors.lightBlueAccent.shade100,
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          '// Loose to a maximum\n'
          'const vc = ViewConstraints(\n'
          '  maxWidth: 800,\n'
          '  maxHeight: 600,\n'
          ');',
          Colors.greenAccent.shade100,
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          '// Tight: only one Size satisfies it\n'
          'final vc = ViewConstraints.tight(\n'
          '  Size(400, 300),\n'
          ');\n'
          'assert(vc.isTight);\n'
          'assert(vc.isSatisfiedBy(Size(400, 300)));',
          Colors.pinkAccent.shade100,
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          '// Logical-pixel constraints from physical\n'
          'final physical = view.physicalConstraints;\n'
          'final logical  = physical / view.devicePixelRatio;',
          Colors.amberAccent.shade100,
        ),
        const SizedBox(height: 8.0),
        _codeBlock(
          '// Equality is value-based\n'
          'const a = ViewConstraints(maxWidth: 10);\n'
          'const b = ViewConstraints(maxWidth: 10);\n'
          'assert(a == b);\n'
          'assert(a.hashCode == b.hashCode);',
          Colors.tealAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: FAQ
  // ============================================================
  print('=== Section 10: FAQ ===');

  final Widget faq = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: shadowSoft,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'FAQ',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey.shade900),
        ),
        const SizedBox(height: 12.0),
        _faqItem(
          'Why double.infinity defaults?',
          'A default ViewConstraints accepts every size; the engine narrows it as it learns the surface.',
        ),
        _faqItem(
          'How do I get a tight square?',
          'Use ViewConstraints.tight(Size.square(side)). isTight returns true.',
        ),
        _faqItem(
          'Are there shorthand constructors like .expand?',
          'No. Stick to the canonical constructor and ViewConstraints.tight.',
        ),
        _faqItem(
          'Can I shrink one axis only?',
          'Yes. Set tighter bounds on that axis and leave the other at defaults.',
        ),
        _faqItem(
          'How do I check if my draw size is allowed?',
          'isSatisfiedBy(Size). Returns true iff width/height fall inside the rect.',
        ),
        _faqItem(
          'Why does toString print "biggest" or "unconstrained"?',
          'Special-cased pretty printing in dart:ui — shorthand for two extreme corners.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: ASCII FOOTER
  // ============================================================
  print('=== Section 11: ASCII footer ===');

  final Widget asciiFooter = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: gradFooter,
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: shadowStrong,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal, color: Colors.greenAccent.shade100, size: 20.0),
            const SizedBox(width: 8.0),
            const Text(
              'ASCII anatomy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            '  +------------- maxWidth -------------+\n'
            '  |                                    |\n'
            '  |  +-----------------------+         |\n'
            '  |  | acceptable size box  |         |\n'
            '  |  |  (isSatisfiedBy yes) |         |\n'
            '  |  +-----------------------+         |\n'
            '  |                                    |\n'
            '  |   minWidth ↘  ↗ minHeight          |\n'
            '  |                                    |\n'
            '  +------------------------------------+\n'
            '\n'
            '  isTight  := minW>=maxW  &&  minH>=maxH\n'
            '  vc / k   := each bound divided by k',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );

  print('ViewConstraints Deep Demo completed successfully');

  // ============================================================
  // ASSEMBLE THE FINAL TREE
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroBanner,
            const SizedBox(height: 24.0),
            _sectionTitle('1. Anatomy'),
            anatomy,
            const SizedBox(height: 28.0),
            _sectionTitle('2. Per-field cards'),
            perFieldCards,
            const SizedBox(height: 28.0),
            _sectionTitle('3. isSatisfiedBy grid'),
            satisfiedGrid,
            const SizedBox(height: 28.0),
            _sectionTitle('4. Recipes'),
            recipes,
            const SizedBox(height: 28.0),
            _sectionTitle('5. Pitfalls'),
            pitfalls,
            const SizedBox(height: 28.0),
            _sectionTitle('6. vs BoxConstraints'),
            vsBox,
            const SizedBox(height: 28.0),
            _sectionTitle('7. PlatformDispatcher probe'),
            platformPanel,
            const SizedBox(height: 28.0),
            _sectionTitle('8. Quick reference'),
            quickRef,
            const SizedBox(height: 28.0),
            _sectionTitle('9. FAQ'),
            faq,
            const SizedBox(height: 28.0),
            _sectionTitle('10. ASCII footer'),
            asciiFooter,
            const SizedBox(height: 24.0),
            Center(
              child: Text(
                'ViewConstraints — dart:ui — Deep Visual Demo',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

class _ProbedConstraints {
  _ProbedConstraints(this.label, this.constraints, this.color);
  final String label;
  final ui.ViewConstraints constraints;
  final Color color;
}

Widget _sectionTitle(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 4.0, bottom: 10.0, top: 4.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w500),
    ),
  );
}

Widget _anatomyDiagram(ui.ViewConstraints vc) {
  // Draw a stylised rectangle with width/height ranges marked.
  // The widths used here are visual proxies, not literal pixel sizes.
  const double diagramWidth = 360.0;
  const double diagramHeight = 220.0;
  final double minWFrac = (vc.minWidth / 800.0).clamp(0.0, 1.0);
  final double maxWFrac = (vc.maxWidth / 800.0).clamp(0.0, 1.0);
  final double minHFrac = (vc.minHeight / 600.0).clamp(0.0, 1.0);
  final double maxHFrac = (vc.maxHeight / 600.0).clamp(0.0, 1.0);

  return Center(
    child: Container(
      width: diagramWidth,
      height: diagramHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blueGrey.shade400, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 6.0, offset: const Offset(0.0, 2.0)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          // maxWidth band (full width minus padding)
          Positioned(
            left: 12.0,
            right: 12.0,
            top: 18.0,
            child: Container(
              height: 6.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.cyan.shade200, Colors.cyan.shade600],
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
          // minWidth band (a fraction of available width)
          Positioned(
            left: 12.0,
            top: 32.0,
            child: Container(
              width: (diagramWidth - 24.0) * (minWFrac == 0.0 ? 0.18 : minWFrac),
              height: 6.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.teal.shade200, Colors.teal.shade600],
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
          // The "acceptable size" rectangle
          Positioned(
            left: 60.0,
            top: 60.0,
            child: Container(
              width: 200.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.indigo.shade300, width: 1.2),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.check_circle, color: Colors.indigo.shade400, size: 28.0),
                    const SizedBox(height: 4.0),
                    Text(
                      'isSatisfiedBy = true',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.indigo.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      'minW=${vc.minWidth}, maxW=${vc.maxWidth}\nminH=${vc.minHeight}, maxH=${vc.maxHeight}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10.0, color: Colors.indigo.shade700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // maxHeight tag
          Positioned(
            right: 14.0,
            top: 60.0,
            child: _axisTag('maxH=${vc.maxHeight}', Colors.orange),
          ),
          // minHeight tag
          Positioned(
            right: 14.0,
            bottom: 18.0,
            child: _axisTag('minH=${vc.minHeight}', Colors.green),
          ),
          // minWidth/maxWidth label tags
          Positioned(
            left: 12.0,
            bottom: 18.0,
            child: Row(
              children: <Widget>[
                _axisTag('minW=${vc.minWidth}', Colors.teal),
                const SizedBox(width: 6.0),
                _axisTag('maxW=${vc.maxWidth}', Colors.cyan.shade700),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _axisTag(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 10.0, color: color, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _anatomyLegend(String label, Color color, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.40)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(width: 10.0, height: 10.0, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6.0),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 11.5, color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 11.5, fontFamily: 'monospace', color: Colors.black87),
        ),
      ],
    ),
  );
}

Widget _fieldCard({
  required String title,
  required String valueText,
  required String description,
  required LinearGradient gradient,
  required Color accent,
  required IconData icon,
  required List<BoxShadow> shadows,
}) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.2),
      boxShadow: shadows,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22.0),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: accent),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            valueText,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.5, color: accent.withValues(alpha: 0.92)),
        ),
      ],
    ),
  );
}

Widget _isSatisfiedRow(_ProbedConstraints pc, List<Size> sizes) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: pc.color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: pc.color.withValues(alpha: 0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.crop_square, color: pc.color, size: 16.0),
            const SizedBox(width: 6.0),
            Text(
              pc.label,
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: pc.color),
            ),
            const SizedBox(width: 8.0),
            Text(
              'isTight=${pc.constraints.isTight}',
              style: TextStyle(fontSize: 11.0, color: pc.color.withValues(alpha: 0.8)),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final Size s in sizes) _sizeChip(s, pc.constraints),
          ],
        ),
      ],
    ),
  );
}

Widget _sizeChip(Size size, ui.ViewConstraints vc) {
  final bool ok = vc.isSatisfiedBy(size);
  final Color base = ok ? Colors.green : Colors.red;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: base.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: base.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(ok ? Icons.check : Icons.close, color: base, size: 14.0),
        const SizedBox(width: 4.0),
        Text(
          '${size.width.toStringAsFixed(0)}x${size.height.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 11.0, color: base, fontFamily: 'monospace'),
        ),
      ],
    ),
  );
}

Widget _recipeCard(String title, String code, String tagline, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.35)),
      boxShadow: <BoxShadow>[
        BoxShadow(color: color.withValues(alpha: 0.18), blurRadius: 8.0, offset: const Offset(0.0, 3.0)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color, size: 20.0),
            const SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent.shade100,
              height: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          tagline,
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

Widget _pitfallRow(String title, String body) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.error_outline, color: Colors.red.shade600, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.red.shade900),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonTable(List<List<String>> rows) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.amber.shade400),
    ),
    child: Column(
      children: <Widget>[
        for (int r = 0; r < rows.length; r++)
          Container(
            decoration: BoxDecoration(
              color: r == 0 ? Colors.amber.shade100 : (r.isOdd ? Colors.amber.shade50 : Colors.white),
              borderRadius: r == 0
                  ? const BorderRadius.vertical(top: Radius.circular(10.0))
                  : BorderRadius.zero,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              children: <Widget>[
                for (int c = 0; c < rows[r].length; c++)
                  Expanded(
                    flex: c == 0 ? 3 : 4,
                    child: Text(
                      rows[r][c],
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: r == 0 ? FontWeight.bold : FontWeight.normal,
                        color: r == 0 ? Colors.amber.shade900 : Colors.grey.shade800,
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

Widget _codeBlock(String code, Color color) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: color, height: 1.4),
    ),
  );
}

Widget _faqItem(String q, String a) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.help_outline, color: Colors.indigo.shade400, size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                q,
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.indigo.shade800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            a,
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800, height: 1.35),
          ),
        ),
      ],
    ),
  );
}
