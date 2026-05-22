// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: ExcludeSemantics (and its render-object backing
// RenderExcludeSemantics) from the rendering library.
//
// Design plan
// -----------
// This script is a static, AST-rendered exploration of ExcludeSemantics.
// It assumes no input events, no animations, no async work and no
// navigation. Every section emits a `=== Section N: ... ===` banner via
// print() and then builds real Flutter widgets that are stitched into a
// scrollable Column inside the root widget's Scaffold body.
//
// Sections:
//   1. Header gradient banner introducing the widget and its render-object.
//   2. The excluding flag (excluding=true vs excluding=false) with paired
//      visual swatches representing the conceptual semantics tree branch.
//   3. Side-by-side comparison panels: same widget subtree wrapped (or not)
//      in ExcludeSemantics, with a "pruned" visualisation overlay.
//   4. Conceptual semantics-tree diagrams using nested labelled containers
//      to show what reaches the screen reader vs what gets pruned.
//   5. A decision tree: exclude vs merge vs preserve, rendered as a step
//      ladder with branching choices and rationale.
//   6. Common recipe gallery (decorative icons, redundant text labels,
//      custom buttons, layered overlays, scroll edges).
//   7. Interaction matrix with Semantics, MergeSemantics, BlockSemantics
//      and ExcludeSemanticsScrollEdges, with short narrative blurbs.
//   8. Glossary and recipes summary closer.
//
// Material 3 ColorScheme idioms are used throughout (primaryContainer,
// secondaryContainer, tertiaryContainer, errorContainer, surfaceVariant,
// outlineVariant). Plain ASCII only in comments. No emoji.
import 'package:flutter/material.dart';

// =====================================================================
// Lightweight data holders so the build code stays readable. These are
// plain const records of strings/colors/icons.
// =====================================================================

class _RecipePattern {
  final String title;
  final String when;
  final String how;
  final IconData icon;
  const _RecipePattern(this.title, this.when, this.how, this.icon);
}

class _DecisionBranch {
  final String question;
  final String yesPath;
  final String noPath;
  final IconData icon;
  const _DecisionBranch(this.question, this.yesPath, this.noPath, this.icon);
}

class _GlossaryEntry {
  final String term;
  final String meaning;
  const _GlossaryEntry(this.term, this.meaning);
}

class _SemanticsNode {
  final String label;
  final bool exposed;
  final List<_SemanticsNode> children;
  const _SemanticsNode(this.label, this.exposed, [this.children = const []]);
}

// =====================================================================
// Root application widget. Stateless, Material 3, scroll-only layout.
// =====================================================================

class ExcludeSemanticsDeepDemoApp extends StatelessWidget {
  const ExcludeSemanticsDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('ExcludeSemantics deep demo: building root widget tree');
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF3C6E91),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExcludeSemantics Deep Demo',
      theme: ThemeData(colorScheme: scheme, useMaterial3: true),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(scheme),
              const SizedBox(height: 28.0),
              _buildSectionOne(scheme),
              const SizedBox(height: 32.0),
              _buildSectionTwo(scheme),
              const SizedBox(height: 32.0),
              _buildSectionThree(scheme),
              const SizedBox(height: 32.0),
              _buildSectionFour(scheme),
              const SizedBox(height: 32.0),
              _buildSectionFive(scheme),
              const SizedBox(height: 32.0),
              _buildSectionSix(scheme),
              const SizedBox(height: 32.0),
              _buildSectionSeven(scheme),
              const SizedBox(height: 32.0),
              _buildSectionEight(scheme),
              const SizedBox(height: 24.0),
              _buildClosingBanner(scheme),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // Header gradient banner (Section 0 - introductory chrome).
  // -------------------------------------------------------------------
  Widget _buildHeaderBanner(ColorScheme scheme) {
    print('=== Section 0: Header banner (intro chrome) ===');
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
            scheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  Icons.visibility_off_outlined,
                  size: 40.0,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ExcludeSemantics',
                      style: TextStyle(
                        color: scheme.onPrimary,
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'rendering / widgets - prune subtrees from the accessibility tree',
                      style: TextStyle(
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: scheme.onPrimary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: scheme.onPrimary.withValues(alpha: 0.25),
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline, color: scheme.onPrimary, size: 18.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'ExcludeSemantics drops its subtree from the semantics tree '
                    'when excluding is true. The render-object peer is '
                    'RenderExcludeSemantics. This demo renders concept diagrams '
                    'because actual screen-reader output is invisible.',
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _headerChip(scheme, 'excluding flag', Icons.flag_outlined),
              _headerChip(scheme, 'Semantics interop', Icons.share_outlined),
              _headerChip(scheme, 'MergeSemantics', Icons.merge_type_outlined),
              _headerChip(scheme, 'BlockSemantics', Icons.block_outlined),
              _headerChip(
                  scheme, 'ExcludeSemanticsScrollEdges', Icons.swap_vert),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerChip(ColorScheme scheme, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: scheme.onPrimary.withValues(alpha: 0.30),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: scheme.onPrimary, size: 14.0),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 1: The excluding flag.
  // -------------------------------------------------------------------
  Widget _buildSectionOne(ColorScheme scheme) {
    print('=== Section 1: The excluding flag ===');

    // Build two paired tiles representing excluding=false and excluding=true.
    final Widget falseTile = _flagTile(
      scheme: scheme,
      flag: false,
      title: 'excluding: false',
      subtitle:
          'Subtree is included normally. Labels, hints and traversal order '
          'remain reachable for assistive tech.',
      bgContainer: scheme.primaryContainer,
      fgContainer: scheme.onPrimaryContainer,
      icon: Icons.visibility_outlined,
    );

    final Widget trueTile = _flagTile(
      scheme: scheme,
      flag: true,
      title: 'excluding: true',
      subtitle:
          'Subtree is removed from semantics. Screen readers skip every '
          'descendant - even if those descendants have their own Semantics.',
      bgContainer: scheme.errorContainer,
      fgContainer: scheme.onErrorContainer,
      icon: Icons.visibility_off_outlined,
    );

    return _sectionFrame(
      scheme: scheme,
      number: 1,
      title: 'The excluding flag',
      lede:
          'ExcludeSemantics takes a single boolean - excluding - that toggles '
          'whether descendants are pruned. excluding is final on the widget '
          'and is forwarded to RenderExcludeSemantics.excluding.',
      content: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: falseTile),
              const SizedBox(width: 14.0),
              Expanded(child: trueTile),
            ],
          ),
          const SizedBox(height: 18.0),
          _codeBlock(
            scheme: scheme,
            language: 'dart',
            code: 'ExcludeSemantics(\n'
                '  excluding: true,\n'
                '  child: const Icon(Icons.star_outline),\n'
                ')\n'
                '\n'
                '// Render-object peer:\n'
                '// RenderExcludeSemantics(excluding: true)\n'
                '//   ..describeSemanticsConfiguration omits this node\n'
                '//   when excluding is true.',
          ),
        ],
      ),
    );
  }

  Widget _flagTile({
    required ColorScheme scheme,
    required bool flag,
    required String title,
    required String subtitle,
    required Color bgContainer,
    required Color fgContainer,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgContainer,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: scheme.outlineVariant,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: fgContainer, size: 22.0),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: fgContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            subtitle,
            style: TextStyle(
              color: fgContainer,
              fontSize: 12.0,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14.0),
          // A miniature visual of the conceptual subtree.
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: scheme.outlineVariant, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _miniSemanticsRow(
                  scheme: scheme,
                  label: 'parent',
                  exposed: true,
                ),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: '  child A',
                  exposed: !flag,
                ),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: '  child B',
                  exposed: !flag,
                ),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: '    grandchild',
                  exposed: !flag,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniSemanticsRow({
    required ColorScheme scheme,
    required String label,
    required bool exposed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Icon(
            exposed ? Icons.check_circle : Icons.cancel_outlined,
            size: 14.0,
            color: exposed ? scheme.primary : scheme.error,
          ),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: exposed ? scheme.onSurface : scheme.error,
              decoration:
                  exposed ? TextDecoration.none : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 2: Side-by-side comparison panels.
  // -------------------------------------------------------------------
  Widget _buildSectionTwo(ColorScheme scheme) {
    print('=== Section 2: Side-by-side comparison panels ===');

    // Re-use the same conceptual subtree definition for both columns.
    final Widget originalSubtree = _conceptualWidgetCard(
      scheme: scheme,
      headline: 'Product card',
      label: 'Star rating, price tag, and a thumbnail.',
      icons: const <IconData>[
        Icons.star,
        Icons.attach_money,
        Icons.image_outlined,
      ],
      surface: scheme.surfaceContainerHigh,
      foreground: scheme.onSurface,
    );

    return _sectionFrame(
      scheme: scheme,
      number: 2,
      title: 'Side-by-side: with vs without ExcludeSemantics',
      lede:
          'Visually identical widget trees. The accessibility tree differs: '
          'the right column hides the entire decoration from screen readers '
          'because the relevant labels live on the surrounding card.',
      content: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _comparisonColumn(
                  scheme: scheme,
                  heading: 'Without ExcludeSemantics',
                  caption: 'Default behaviour. Every Icon and Text exposes '
                      'its own semantics node.',
                  exposeAll: true,
                  child: originalSubtree,
                  accent: scheme.tertiaryContainer,
                  onAccent: scheme.onTertiaryContainer,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _comparisonColumn(
                  scheme: scheme,
                  heading: 'With ExcludeSemantics(excluding: true)',
                  caption: 'Same pixels. The subtree is pruned, so the screen '
                      'reader only sees the outer card label.',
                  exposeAll: false,
                  child: originalSubtree,
                  accent: scheme.errorContainer,
                  onAccent: scheme.onErrorContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          _calloutBar(
            scheme: scheme,
            icon: Icons.lightbulb_outline,
            tone: scheme.secondaryContainer,
            onTone: scheme.onSecondaryContainer,
            message:
                'Pixels are identical: ExcludeSemantics does not paint, lay '
                'out or hit-test anything itself. It only affects the '
                'semantics tree produced during the semantics pipeline.',
          ),
        ],
      ),
    );
  }

  Widget _comparisonColumn({
    required ColorScheme scheme,
    required String heading,
    required String caption,
    required bool exposeAll,
    required Widget child,
    required Color accent,
    required Color onAccent,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            heading,
            style: TextStyle(
              color: onAccent,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            caption,
            style: TextStyle(
              color: onAccent,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12.0),
          // Visual subtree
          child,
          const SizedBox(height: 12.0),
          // Conceptual semantics overlay
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: scheme.outlineVariant, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_tree_outlined,
                      size: 14.0,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Semantics tree (conceptual)',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: 'card',
                  exposed: true,
                ),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: '  rating',
                  exposed: exposeAll,
                ),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: '  price',
                  exposed: exposeAll,
                ),
                _miniSemanticsRow(
                  scheme: scheme,
                  label: '  thumbnail',
                  exposed: exposeAll,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _conceptualWidgetCard({
    required ColorScheme scheme,
    required String headline,
    required String label,
    required List<IconData> icons,
    required Color surface,
    required Color foreground,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            headline,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(
              color: foreground.withValues(alpha: 0.75),
              fontSize: 11.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              for (final IconData icon in icons)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(
                      icon,
                      size: 18.0,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 3: Conceptual semantics tree diagram.
  // -------------------------------------------------------------------
  Widget _buildSectionThree(ColorScheme scheme) {
    print('=== Section 3: Conceptual semantics tree diagram ===');

    const _SemanticsNode root = _SemanticsNode(
      'Scaffold',
      true,
      <_SemanticsNode>[
        _SemanticsNode(
          'AppBar (title: Profile)',
          true,
          <_SemanticsNode>[
            _SemanticsNode('back button', true),
            _SemanticsNode('overflow menu', true),
          ],
        ),
        _SemanticsNode(
          'ListTile (Account)',
          true,
          <_SemanticsNode>[
            _SemanticsNode('leading avatar (decorative)', false),
            _SemanticsNode('title text', true),
            _SemanticsNode('subtitle text', true),
            _SemanticsNode('trailing chevron (decorative)', false),
          ],
        ),
        _SemanticsNode(
          'Banner (decorative gradient)',
          false,
          <_SemanticsNode>[
            _SemanticsNode('emoji icon (decorative)', false),
            _SemanticsNode('background text', false),
          ],
        ),
      ],
    );

    return _sectionFrame(
      scheme: scheme,
      number: 3,
      title: 'Conceptual semantics tree',
      lede:
          'Pruned nodes are crossed out and tinted with errorContainer. Live '
          'nodes use primaryContainer. Tree drawn with nested labelled rows '
          'and indentation guides.',
      content: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: scheme.outlineVariant, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _treeLegend(scheme),
            const SizedBox(height: 12.0),
            ..._renderSemanticsNode(scheme, root, 0),
          ],
        ),
      ),
    );
  }

  Widget _treeLegend(ColorScheme scheme) {
    return Row(
      children: <Widget>[
        _legendDot(scheme, scheme.primary, 'exposed to AT'),
        const SizedBox(width: 16.0),
        _legendDot(scheme, scheme.error, 'pruned by ExcludeSemantics'),
      ],
    );
  }

  Widget _legendDot(ColorScheme scheme, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(fontSize: 11.0, color: scheme.onSurface),
        ),
      ],
    );
  }

  List<Widget> _renderSemanticsNode(
    ColorScheme scheme,
    _SemanticsNode node,
    int depth,
  ) {
    final List<Widget> out = <Widget>[];
    final double indent = depth * 18.0;
    final Color tone =
        node.exposed ? scheme.primaryContainer : scheme.errorContainer;
    final Color onTone =
        node.exposed ? scheme.onPrimaryContainer : scheme.onErrorContainer;

    out.add(
      Padding(
        padding: EdgeInsets.only(left: indent, top: 4.0, bottom: 4.0),
        child: Row(
          children: <Widget>[
            if (depth > 0)
              Container(
                width: 10.0,
                height: 1.0,
                color: scheme.outlineVariant,
              ),
            if (depth > 0) const SizedBox(width: 6.0),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: scheme.outlineVariant,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      node.exposed
                          ? Icons.record_voice_over_outlined
                          : Icons.voice_over_off_outlined,
                      size: 14.0,
                      color: onTone,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      node.label,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: onTone,
                        fontWeight: FontWeight.w600,
                        decoration: node.exposed
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
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

    for (final _SemanticsNode child in node.children) {
      out.addAll(_renderSemanticsNode(scheme, child, depth + 1));
    }
    return out;
  }

  // -------------------------------------------------------------------
  // SECTION 4: Decision tree - exclude vs merge vs preserve.
  // -------------------------------------------------------------------
  Widget _buildSectionFour(ColorScheme scheme) {
    print('=== Section 4: Decision tree ===');

    const List<_DecisionBranch> branches = <_DecisionBranch>[
      _DecisionBranch(
        'Is the widget purely decorative?',
        'Wrap in ExcludeSemantics(excluding: true).',
        'Move to the next question.',
        Icons.brush_outlined,
      ),
      _DecisionBranch(
        'Does another widget already announce the same meaning?',
        'Exclude the duplicate so the screen reader is not noisy.',
        'Keep both - the labels reinforce, not duplicate.',
        Icons.repeat_outlined,
      ),
      _DecisionBranch(
        'Are the children a tightly bound group (icon + label)?',
        'Use MergeSemantics so they become one announced unit.',
        'Leave each child as its own semantics node.',
        Icons.merge_type_outlined,
      ),
      _DecisionBranch(
        'Does the widget overlay an interactive surface and block it?',
        'Combine ExcludeSemantics for visuals with BlockSemantics for siblings.',
        'Plain ExcludeSemantics is enough.',
        Icons.layers_outlined,
      ),
    ];

    return _sectionFrame(
      scheme: scheme,
      number: 4,
      title: 'Decision tree: exclude vs merge vs preserve',
      lede:
          'Walk the questions top to bottom. The first Yes that matches the '
          'situation gives the recommended approach.',
      content: Column(
        children: <Widget>[
          for (int i = 0; i < branches.length; i++)
            _decisionStep(scheme, i + 1, branches[i],
                isLast: i == branches.length - 1),
        ],
      ),
    );
  }

  Widget _decisionStep(
    ColorScheme scheme,
    int stepNumber,
    _DecisionBranch branch, {
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: scheme.primary.withValues(alpha: 0.35),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$stepNumber',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2.0,
                height: 60.0,
                color: scheme.outlineVariant,
              ),
          ],
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0.0 : 14.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: scheme.outlineVariant, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(branch.icon, color: scheme.primary, size: 18.0),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        branch.question,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _yesNoRow(
                  scheme: scheme,
                  label: 'YES',
                  text: branch.yesPath,
                  tone: scheme.primaryContainer,
                  onTone: scheme.onPrimaryContainer,
                  icon: Icons.check,
                ),
                const SizedBox(height: 6.0),
                _yesNoRow(
                  scheme: scheme,
                  label: 'NO',
                  text: branch.noPath,
                  tone: scheme.surfaceContainerHighest,
                  onTone: scheme.onSurface,
                  icon: Icons.arrow_downward,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _yesNoRow({
    required ColorScheme scheme,
    required String label,
    required String text,
    required Color tone,
    required Color onTone,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: onTone, size: 14.0),
          const SizedBox(width: 8.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: onTone.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: onTone,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: onTone,
                fontSize: 12.0,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 5: Recipe gallery.
  // -------------------------------------------------------------------
  Widget _buildSectionFive(ColorScheme scheme) {
    print('=== Section 5: Recipe gallery ===');

    const List<_RecipePattern> recipes = <_RecipePattern>[
      _RecipePattern(
        'Decorative icons',
        'Icons that repeat information already in a text label.',
        'Wrap the icon (or icon row) in ExcludeSemantics(excluding: true). '
            'The text label remains the single announced source of truth.',
        Icons.brush_outlined,
      ),
      _RecipePattern(
        'Redundant labels',
        'A heading text plus a tooltip plus an aria-style label all say '
            '"Settings".',
        'Exclude two of the three. Keep the most descriptive one - usually '
            'the Semantics widget with the longest label and hint.',
        Icons.label_off_outlined,
      ),
      _RecipePattern(
        'Custom buttons with internal art',
        'A button whose child contains decorative icons, dividers and '
            'shading containers.',
        'Wrap the inner art in ExcludeSemantics and put the button label on '
            'the outer Semantics or Material.button.',
        Icons.smart_button_outlined,
      ),
      _RecipePattern(
        'Layered hero overlays',
        'A decorative gradient overlays an interactive surface.',
        'Use ExcludeSemantics for the gradient and consider BlockSemantics '
            'on the overlay so siblings below remain announced normally.',
        Icons.layers_outlined,
      ),
      _RecipePattern(
        'Scroll edge shadows',
        'Edge shadows or fade overlays at the start/end of a list.',
        'ExcludeSemanticsScrollEdges already wraps the edges so they do not '
            'appear as semantics nodes - prefer it to manual ExcludeSemantics.',
        Icons.swap_vert,
      ),
      _RecipePattern(
        'Avatar placeholders',
        'Initials or silhouette icons next to the user name.',
        'Wrap the avatar in ExcludeSemantics(excluding: true) so the name '
            'is announced once instead of "JD, John Doe".',
        Icons.person_outline,
      ),
    ];

    return _sectionFrame(
      scheme: scheme,
      number: 5,
      title: 'Recipe gallery',
      lede:
          'Six concrete patterns. Each card describes when the pattern fires '
          'and the suggested ExcludeSemantics treatment.',
      content: Wrap(
        spacing: 14.0,
        runSpacing: 14.0,
        children: <Widget>[
          for (final _RecipePattern recipe in recipes)
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 280.0,
                maxWidth: 360.0,
              ),
              child: _recipeCard(scheme, recipe),
            ),
        ],
      ),
    );
  }

  Widget _recipeCard(ColorScheme scheme, _RecipePattern recipe) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: scheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  recipe.icon,
                  color: scheme.onTertiaryContainer,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  recipe.title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          _labelledBlock(
            scheme: scheme,
            label: 'When',
            text: recipe.when,
            tone: scheme.secondaryContainer,
            onTone: scheme.onSecondaryContainer,
          ),
          const SizedBox(height: 8.0),
          _labelledBlock(
            scheme: scheme,
            label: 'How',
            text: recipe.how,
            tone: scheme.primaryContainer,
            onTone: scheme.onPrimaryContainer,
          ),
        ],
      ),
    );
  }

  Widget _labelledBlock({
    required ColorScheme scheme,
    required String label,
    required String text,
    required Color tone,
    required Color onTone,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: onTone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: onTone,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            text,
            style: TextStyle(
              color: onTone,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 6: Interaction with Semantics / MergeSemantics / BlockSemantics
  //            and ExcludeSemanticsScrollEdges.
  // -------------------------------------------------------------------
  Widget _buildSectionSix(ColorScheme scheme) {
    print('=== Section 6: Interaction matrix ===');

    final List<List<String>> rows = <List<String>>[
      <String>[
        'Semantics(label: ...)',
        'Pruned',
        'The Semantics widget is inside the excluded subtree, so its label '
            'is never produced.',
      ],
      <String>[
        'MergeSemantics',
        'Pruned',
        'Merge boundaries inside the excluded subtree do not survive because '
            'the entire subtree is gone before the merge would happen.',
      ],
      <String>[
        'BlockSemantics',
        'Sibling-blocking still applies',
        'BlockSemantics works on prior siblings. If you exclude a subtree '
            'but want to also block earlier siblings, combine the two.',
      ],
      <String>[
        'ExcludeSemanticsScrollEdges',
        'Specialised wrapper',
        'A scroll-aware variant that excludes the scroll edge shadows. '
            'Prefer it over manual ExcludeSemantics around scroll edges.',
      ],
      <String>[
        'Tooltip',
        'Pruned',
        'A Tooltip beneath an excluded ancestor does not announce. Place '
            'tooltips above the ExcludeSemantics boundary if they should '
            'remain audible.',
      ],
      <String>[
        'IndexedSemantics',
        'Pruned',
        'Index hints are dropped along with the rest of the subtree, so '
            'list ordering must come from a different surviving subtree.',
      ],
    ];

    return _sectionFrame(
      scheme: scheme,
      number: 6,
      title: 'Interaction with neighbouring semantics widgets',
      lede:
          'Six common neighbours and how ExcludeSemantics changes them. The '
          'second column states the resulting behaviour; the third column '
          'explains why.',
      content: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: scheme.outlineVariant, width: 1.0),
        ),
        child: Column(
          children: <Widget>[
            _interactionHeaderRow(scheme),
            const Divider(height: 16.0),
            for (int i = 0; i < rows.length; i++)
              _interactionRow(scheme, rows[i], i),
          ],
        ),
      ),
    );
  }

  Widget _interactionHeaderRow(ColorScheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _columnHeader(scheme, 'Neighbour widget'),
          ),
          Expanded(
            flex: 2,
            child: _columnHeader(scheme, 'Result inside ExcludeSemantics'),
          ),
          Expanded(
            flex: 5,
            child: _columnHeader(scheme, 'Why'),
          ),
        ],
      ),
    );
  }

  Widget _columnHeader(ColorScheme scheme, String label) {
    return Text(
      label,
      style: TextStyle(
        color: scheme.primary,
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _interactionRow(ColorScheme scheme, List<String> row, int index) {
    final Color bg = index.isEven
        ? scheme.surfaceContainerHigh
        : scheme.surfaceContainerHighest;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              row[0],
              style: TextStyle(
                fontFamily: 'monospace',
                color: scheme.onSurface,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row[1],
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              row[2],
              style: TextStyle(
                color: scheme.onSurface.withValues(alpha: 0.85),
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 7: Anti-patterns and gotchas.
  // -------------------------------------------------------------------
  Widget _buildSectionSeven(ColorScheme scheme) {
    print('=== Section 7: Anti-patterns and gotchas ===');

    final List<Map<String, String>> antiPatterns = <Map<String, String>>[
      <String, String>{
        'title': 'Excluding interactive widgets',
        'body':
            'Wrapping a Button or TextField in ExcludeSemantics(excluding: '
                'true) makes the control unreachable by screen readers. Use '
                'Semantics(label: ...) to override the announcement instead.',
      },
      <String, String>{
        'title': 'Excluding the whole list',
        'body':
            'A whole ListView under ExcludeSemantics(excluding: true) hides '
                'every item, including their tap handlers. Limit exclusion to '
                'decorative tiles or use ExcludeSemanticsScrollEdges for edges.',
      },
      <String, String>{
        'title': 'Excluding a form label',
        'body':
            'A label paired with a text field must remain announced. If you '
                'must hide the visible text, keep its semantics or move the '
                'label to a Semantics(label: ...) on the TextField wrapper.',
      },
      <String, String>{
        'title': 'Stacked excludes',
        'body':
            'ExcludeSemantics inside another ExcludeSemantics is redundant - '
                'the outer one already prunes the subtree. Remove the inner '
                'wrapper for clarity.',
      },
      <String, String>{
        'title': 'Excluding tooltip-only controls',
        'body':
            'If a button only conveys meaning through its tooltip, do not '
                'exclude the tooltip - it is the only assistive text.',
      },
      <String, String>{
        'title': 'Forgetting MergeSemantics',
        'body':
            'Sometimes the goal is not to prune but to merge. If you only '
                'need a single announcement instead of three, use '
                'MergeSemantics; ExcludeSemantics would erase too much.',
      },
    ];

    return _sectionFrame(
      scheme: scheme,
      number: 7,
      title: 'Anti-patterns and gotchas',
      lede:
          'Cases where ExcludeSemantics looks attractive but harms users. '
          'Each card lists the trap and the safer alternative.',
      content: Wrap(
        spacing: 14.0,
        runSpacing: 14.0,
        children: <Widget>[
          for (final Map<String, String> pattern in antiPatterns)
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300.0,
                maxWidth: 360.0,
              ),
              child: _antiPatternCard(scheme, pattern),
            ),
        ],
      ),
    );
  }

  Widget _antiPatternCard(ColorScheme scheme, Map<String, String> pattern) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.errorContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: scheme.error.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.warning_amber_rounded,
                color: scheme.onErrorContainer,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  pattern['title']!,
                  style: TextStyle(
                    color: scheme.onErrorContainer,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            pattern['body']!,
            style: TextStyle(
              color: scheme.onErrorContainer,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 8: Glossary and final recipes summary.
  // -------------------------------------------------------------------
  Widget _buildSectionEight(ColorScheme scheme) {
    print('=== Section 8: Glossary and recipes summary ===');

    const List<_GlossaryEntry> glossary = <_GlossaryEntry>[
      _GlossaryEntry(
        'ExcludeSemantics',
        'Widget that drops its subtree from the semantics tree when '
            'excluding is true.',
      ),
      _GlossaryEntry(
        'RenderExcludeSemantics',
        'Render-object peer that implements describeSemanticsConfiguration '
            'and visitChildrenForSemantics to perform the pruning.',
      ),
      _GlossaryEntry(
        'excluding',
        'Final boolean controlling pruning. true prunes, false leaves the '
            'subtree untouched.',
      ),
      _GlossaryEntry(
        'Semantics',
        'Widget that attaches an explicit semantics node with labels, '
            'hints, actions and flags.',
      ),
      _GlossaryEntry(
        'MergeSemantics',
        'Widget that merges its descendants into a single semantics node.',
      ),
      _GlossaryEntry(
        'BlockSemantics',
        'Widget that hides all previous siblings on the same tree level so '
            'modal layers can take over.',
      ),
      _GlossaryEntry(
        'ExcludeSemanticsScrollEdges',
        'Scroll-aware wrapper that excludes the leading or trailing edge '
            'decorations of a Scrollable from the semantics tree.',
      ),
      _GlossaryEntry(
        'Semantics tree',
        'Per-frame snapshot exposed to the platform accessibility layer; '
            'distinct from the widget and render trees.',
      ),
      _GlossaryEntry(
        'Decorative',
        'A widget that conveys no unique information beyond what siblings '
            'already announce.',
      ),
    ];

    return _sectionFrame(
      scheme: scheme,
      number: 8,
      title: 'Glossary and recipes summary',
      lede:
          'Quick reference for the terms used throughout this demo, plus a '
          'compact recap of the top three recipes.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: scheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: scheme.outlineVariant, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.menu_book_outlined,
                      color: scheme.onTertiaryContainer,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Glossary',
                      style: TextStyle(
                        color: scheme.onTertiaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                for (final _GlossaryEntry entry in glossary)
                  _glossaryRow(scheme, entry),
              ],
            ),
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: scheme.outlineVariant, width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.checklist_rtl_outlined,
                      color: scheme.onPrimaryContainer,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Top three recipes',
                      style: TextStyle(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                _summaryRecipeRow(
                  scheme: scheme,
                  number: 1,
                  title: 'Hide decorative icons',
                  text:
                      'Wrap the icon row in ExcludeSemantics(excluding: true).',
                ),
                _summaryRecipeRow(
                  scheme: scheme,
                  number: 2,
                  title: 'Suppress duplicate labels',
                  text:
                      'Pick one canonical announcement and exclude the rest.',
                ),
                _summaryRecipeRow(
                  scheme: scheme,
                  number: 3,
                  title: 'Layer with BlockSemantics',
                  text:
                      'Combine ExcludeSemantics with BlockSemantics for modal '
                      'overlays that should also block siblings.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glossaryRow(ColorScheme scheme, _GlossaryEntry entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5.0, right: 10.0),
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: scheme.onTertiaryContainer,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.5,
                  color: scheme.onTertiaryContainer,
                  height: 1.45,
                ),
                children: <InlineSpan>[
                  TextSpan(
                    text: '${entry.term}: ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: entry.meaning),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRecipeRow({
    required ColorScheme scheme,
    required int number,
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 26.0,
            height: 26.0,
            decoration: BoxDecoration(
              color: scheme.onPrimaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  color: scheme.primaryContainer,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.85),
                    fontSize: 11.5,
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

  // -------------------------------------------------------------------
  // Closing banner (mirrors the header).
  // -------------------------------------------------------------------
  Widget _buildClosingBanner(ColorScheme scheme) {
    print('=== Closing banner ===');
    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.secondary,
            scheme.primary,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.accessibility_new_outlined,
            color: scheme.onPrimary,
            size: 36.0,
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ExcludeSemantics is a scalpel, not a hammer.',
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Use it to remove noise, never to silence meaningful '
                  'controls. When in doubt, prefer Semantics or MergeSemantics.',
                  style: TextStyle(
                    color: scheme.onPrimary.withValues(alpha: 0.92),
                    fontSize: 12.0,
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

  // -------------------------------------------------------------------
  // Shared section frame: numbered heading + lede + content body.
  // -------------------------------------------------------------------
  Widget _sectionFrame({
    required ColorScheme scheme,
    required int number,
    required String title,
    required String lede,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.06),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34.0,
                height: 34.0,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  '=== Section $number: $title ===',
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 17.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: scheme.outlineVariant, width: 1.0),
            ),
            child: Text(
              lede,
              style: TextStyle(
                color: scheme.onSurface.withValues(alpha: 0.85),
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          content,
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Reusable callout bar with a tinted background and message.
  // -------------------------------------------------------------------
  Widget _calloutBar({
    required ColorScheme scheme,
    required IconData icon,
    required Color tone,
    required Color onTone,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: onTone, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: onTone,
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Reusable dark code block.
  // -------------------------------------------------------------------
  Widget _codeBlock({
    required ColorScheme scheme,
    required String language,
    required String code,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2530),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.terminal, color: Colors.cyan.shade300, size: 16.0),
              const SizedBox(width: 6.0),
              Text(
                language,
                style: TextStyle(
                  color: Colors.cyan.shade300,
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.green.shade200,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Application entry point.
// =====================================================================

void main() => runApp(const ExcludeSemanticsDeepDemoApp());
