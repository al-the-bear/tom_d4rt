// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// BlockSemantics deep visual demo.
//
// BlockSemantics is a widget defined in `package:flutter/widgets.dart`.
// Its job is, conceptually, simple but extremely important: when it is
// present in the widget tree and `blocking` is true, it hides every
// semantics node that was painted BEFORE it in the paint order from the
// platform accessibility tree.
//
// In other words: anything that would have appeared "underneath" the
// BlockSemantics in the painting stack is invisible to screen readers,
// even though it remains visible to sighted users (BlockSemantics never
// changes pixels; only semantics).
//
// Why this matters:
//   * Modal barriers (the dim layer behind an open dialog or drawer) use
//     it so that VoiceOver / TalkBack do not "see through" the modal and
//     read out the page underneath, which would be confusing and wrong.
//   * Drawers use it so that the page content behind the open drawer is
//     not read out while the drawer is open.
//   * Dialogs use it so the underlying screen does not leak into the
//     semantics tree when a dialog is open.
//
// What BlockSemantics is NOT:
//   * It is not the same as `ExcludeSemantics`. ExcludeSemantics removes
//     the semantics of its *descendants*, not "everything painted before
//     it". The scope is local to the subtree.
//   * It is not `MergeSemantics`. MergeSemantics merges its descendants
//     into one semantic node, which is the opposite kind of operation
//     (collapsing rather than blocking).
//   * It is not `Semantics(excludeSemantics: true, ...)`. That flag on
//     Semantics widget is similar to ExcludeSemantics in scope.
//
// This file renders a hand-built, fully static visual demo that explains
// BlockSemantics using diagrams, mock UI, comparison tables, code
// snippets, pitfalls, and best practices.
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF101828);
const Color _kInkSoft = Color(0xFF344054);
const Color _kInkMute = Color(0xFF667085);
const Color _kPaper = Color(0xFFFDFDFE);
const Color _kPaperWarm = Color(0xFFFFF8F1);
const Color _kAccent = Color(0xFF6941C6);
const Color _kAccentAlt = Color(0xFF1570EF);
const Color _kGood = Color(0xFF12B76A);
const Color _kBad = Color(0xFFF04438);
const Color _kWarn = Color(0xFFF79009);
const Color _kInfo = Color(0xFF0BA5EC);
const Color _kRule = Color(0xFFE4E7EC);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'BlockSemantics — Deep Visual Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
      useMaterial3: true,
      scaffoldBackgroundColor: _kPaper,
    ),
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _HeroBannerSection(),
            SizedBox(height: 36),
            _ConstructorReferenceSection(),
            SizedBox(height: 36),
            _SemanticsTreeDiagramSection(),
            SizedBox(height: 36),
            _ModalBarrierWalkthroughSection(),
            SizedBox(height: 36),
            _DrawerMockSection(),
            SizedBox(height: 36),
            _ComparisonTableSection(),
            SizedBox(height: 36),
            _PaintOrderRuleSection(),
            SizedBox(height: 36),
            _CodeSnippetGallerySection(),
            SizedBox(height: 36),
            _PitfallsSection(),
            SizedBox(height: 36),
            _BestPracticesSection(),
            SizedBox(height: 36),
            _FooterSection(),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Reusable building blocks. These are simple wrappers that the section
// widgets compose. Keeping them stateless and self-contained ensures
// that the entire demo is a pure tree of widgets that can be replayed
// by an AST interpreter without any runtime state.
// ---------------------------------------------------------------------------

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
    this.eyebrowColor = _kAccent,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;
  final Color eyebrowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(28, 24, 28, 28),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kRule),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: eyebrowColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: eyebrowColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              eyebrow.toUpperCase(),
              style: TextStyle(
                color: eyebrowColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: _kInk,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(color: _kInkMute, fontSize: 14, height: 1.4),
          ),
          SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text, {required this.color, this.bold = false});
  final String text;
  final Color color;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _MonoBlock extends StatelessWidget {
  const _MonoBlock(this.code, {this.caption});
  final String code;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0B1021),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFF1F2A44)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFF0B1021).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (caption != null) ...<Widget>[
            Text(
              caption!,
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 11,
                fontFamily: 'monospace',
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 8),
          ],
          SelectableText(
            code,
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 12.5,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text, {this.tone = _kInkSoft});
  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 7, right: 10),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: tone,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: tone, fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardLite extends StatelessWidget {
  const _CardLite({
    required this.title,
    required this.body,
    this.accent = _kAccent,
  });
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Hero banner section.
// ---------------------------------------------------------------------------

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(32, 36, 32, 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1D2939),
            Color(0xFF4E2A84),
            Color(0xFF6941C6),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.32),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.32),
                  ),
                ),
                child: Text(
                  'package:flutter/widgets.dart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.24),
                  ),
                ),
                child: Text(
                  'Accessibility',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 22),
          Text(
            'BlockSemantics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 44,
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -1.0,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Hide every semantics node painted before me.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.22),
              ),
            ),
            child: Text(
              'BlockSemantics is the unsung hero behind every modal in '
              'Flutter. When a dialog, drawer, bottom sheet, or modal '
              'barrier appears, BlockSemantics is what stops VoiceOver, '
              'TalkBack, and other assistive technologies from reading '
              'the page underneath. It does this without altering a '
              'single visible pixel — it only manipulates the semantics '
              'tree that the platform exposes to accessibility services.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.94),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              _HeroStat(label: 'Visual effect', value: 'None'),
              SizedBox(width: 14),
              _HeroStat(label: 'Semantic effect', value: 'Blocks prior'),
              SizedBox(width: 14),
              _HeroStat(label: 'Rebuild cost', value: 'Tiny'),
              SizedBox(width: 14),
              _HeroStat(label: 'Used by', value: 'Modals'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Constructor reference section.
// ---------------------------------------------------------------------------

class _ConstructorReferenceSection extends StatelessWidget {
  const _ConstructorReferenceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Constructor',
      title: 'The smallest API in Flutter',
      subtitle:
          'BlockSemantics has exactly two parameters: a flag and a child. '
          'It does not animate, does not lay out, does not paint. It only '
          'tags itself in the semantics tree.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _MonoBlock(
            'const BlockSemantics({\n'
            '  Key? key,\n'
            '  bool blocking = true,\n'
            '  Widget? child,\n'
            '})',
            caption: 'constructor signature',
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _ParamCard(
                  name: 'blocking',
                  type: 'bool',
                  defaultValue: 'true',
                  description:
                      'When true (the default), all semantics nodes painted '
                      'before this widget in paint order are dropped from '
                      'the semantics tree. When false, the widget is a '
                      'pure pass-through.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ParamCard(
                  name: 'child',
                  type: 'Widget?',
                  defaultValue: 'null',
                  description:
                      'The child to render. BlockSemantics itself draws '
                      'nothing; the child is rendered normally. Layout '
                      'and painting are unaffected.',
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  _kAccent.withValues(alpha: 0.10),
                  _kAccentAlt.withValues(alpha: 0.10),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kAccent.withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mental model',
                  style: TextStyle(
                    color: _kAccent,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Think of BlockSemantics as a curtain in the accessibility '
                  'theater. The actors painted onto the stage before the '
                  'curtain dropped are no longer announced. The actors that '
                  'painted after the curtain (its subtree, plus anything '
                  'rendered later in the paint order) are still announced.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _Pill('debugFillProperties → blocking', color: _kInfo),
              _Pill('SingleChildRenderObjectWidget', color: _kAccent),
              _Pill('Creates _RenderBlockSemantics', color: _kAccentAlt),
              _Pill('No paint side-effect', color: _kGood),
              _Pill('No layout side-effect', color: _kGood),
            ],
          ),
        ],
      ),
    );
  }
}

class _ParamCard extends StatelessWidget {
  const _ParamCard({
    required this.name,
    required this.type,
    required this.defaultValue,
    required this.description,
  });

  final String name;
  final String type;
  final String defaultValue;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kPaper,
        border: Border.all(color: _kRule),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: _kInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: _kAccent,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'default: $defaultValue',
            style: TextStyle(
              color: _kInkMute,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Semantics tree before / after diagram.
// ---------------------------------------------------------------------------

class _SemanticsTreeDiagramSection extends StatelessWidget {
  const _SemanticsTreeDiagramSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Semantics tree',
      title: 'Before and after BlockSemantics',
      subtitle:
          'Same widget tree, two snapshots of the semantics tree exposed to '
          'the platform: without BlockSemantics, every node is visible. '
          'With BlockSemantics inserted, the nodes painted before it '
          'disappear from the accessibility tree.',
      eyebrowColor: _kAccentAlt,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _TreeColumn(
              title: 'Without BlockSemantics',
              tone: _kBad,
              nodes: <_TreeNode>[
                _TreeNode('Scaffold', 0, isRoot: true),
                _TreeNode('AppBar "Inbox"', 1),
                _TreeNode('ListTile "Email 1"', 1),
                _TreeNode('ListTile "Email 2"', 1),
                _TreeNode('ListTile "Email 3"', 1),
                _TreeNode('ModalBarrier (visible)', 1),
                _TreeNode('Dialog "Delete?"', 2),
                _TreeNode('Button "Cancel"', 3),
                _TreeNode('Button "Delete"', 3),
              ],
              note:
                  'Screen readers can swipe back to the inbox tiles even '
                  'while the dialog is open. They will read them aloud, '
                  'and a user can activate them — a critical accessibility '
                  'bug for modal experiences.',
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _TreeColumn(
              title: 'With BlockSemantics',
              tone: _kGood,
              nodes: <_TreeNode>[
                _TreeNode('Scaffold', 0, isRoot: true, dimmed: true),
                _TreeNode('AppBar "Inbox"', 1, dimmed: true),
                _TreeNode('ListTile "Email 1"', 1, dimmed: true),
                _TreeNode('ListTile "Email 2"', 1, dimmed: true),
                _TreeNode('ListTile "Email 3"', 1, dimmed: true),
                _TreeNode('BlockSemantics ▶ curtain', 1, isCurtain: true),
                _TreeNode('ModalBarrier (visible)', 1),
                _TreeNode('Dialog "Delete?"', 2),
                _TreeNode('Button "Cancel"', 3),
                _TreeNode('Button "Delete"', 3),
              ],
              note:
                  'Everything above the BlockSemantics curtain is dimmed '
                  'because it is no longer exposed to the platform. The '
                  'screen reader sees only the modal content.',
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeColumn extends StatelessWidget {
  const _TreeColumn({
    required this.title,
    required this.tone,
    required this.nodes,
    required this.note,
  });

  final String title;
  final Color tone;
  final List<_TreeNode> nodes;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: <Color>[
            tone.withValues(alpha: 0.06),
            tone.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.account_tree_outlined, size: 16, color: tone),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: tone,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          for (final _TreeNode node in nodes) _TreeNodeWidget(node: node),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              note,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TreeNode {
  const _TreeNode(
    this.label,
    this.depth, {
    this.isRoot = false,
    this.dimmed = false,
    this.isCurtain = false,
  });

  final String label;
  final int depth;
  final bool isRoot;
  final bool dimmed;
  final bool isCurtain;
}

class _TreeNodeWidget extends StatelessWidget {
  const _TreeNodeWidget({required this.node});
  final _TreeNode node;

  @override
  Widget build(BuildContext context) {
    final Color textColor = node.dimmed
        ? _kInkMute.withValues(alpha: 0.55)
        : node.isCurtain
            ? _kAccent
            : _kInk;
    final Color bg = node.isCurtain
        ? _kAccent.withValues(alpha: 0.10)
        : node.dimmed
            ? _kRule.withValues(alpha: 0.4)
            : Colors.white;
    return Padding(
      padding: EdgeInsets.only(left: node.depth * 14.0, top: 3, bottom: 3),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: node.isCurtain
                ? _kAccent.withValues(alpha: 0.45)
                : _kRule,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              node.isRoot
                  ? Icons.account_tree
                  : node.isCurtain
                      ? Icons.block_flipped
                      : node.dimmed
                          ? Icons.visibility_off_outlined
                          : Icons.adjust,
              size: 13,
              color: textColor,
            ),
            SizedBox(width: 6),
            Flexible(
              child: Text(
                node.label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight:
                      node.isCurtain ? FontWeight.w800 : FontWeight.w600,
                  decoration: node.dimmed
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
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
// 4. Modal barrier walkthrough section.
// ---------------------------------------------------------------------------

class _ModalBarrierWalkthroughSection extends StatelessWidget {
  const _ModalBarrierWalkthroughSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Walkthrough',
      title: 'Modal barrier: closed vs. opened',
      subtitle:
          'A side-by-side mock of the same screen with the dialog closed '
          'and opened. Notice how the visible UI changes, and how the '
          'semantic indicators on each tile change as well.',
      eyebrowColor: _kAccentAlt,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _MockPhone(opened: false)),
              SizedBox(width: 16),
              Expanded(child: _MockPhone(opened: true)),
            ],
          ),
          SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  _kInfo.withValues(alpha: 0.10),
                  _kAccentAlt.withValues(alpha: 0.10),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccentAlt.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.bolt_outlined, size: 16, color: _kAccentAlt),
                    SizedBox(width: 6),
                    Text(
                      'What the screen reader experiences',
                      style: TextStyle(
                        color: _kAccentAlt,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'In the closed state, swiping right reads "Email 1", '
                  '"Email 2", "Email 3" and "Compose". In the opened '
                  'state, BlockSemantics drops all four of those nodes. '
                  'Swiping right reads only "Delete this draft?", '
                  '"Cancel" and "Delete". The user cannot accidentally '
                  'tap a list tile they cannot see.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockPhone extends StatelessWidget {
  const _MockPhone({required this.opened});
  final bool opened;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFEAECF0),
            Color(0xFFD0D5DD),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.10),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 460,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _MockAppBar(),
                  _MockTile('Email 1 — Project status', 'You have 3 unread',
                      blocked: opened),
                  _MockTile('Email 2 — Lunch tomorrow?', 'From: Mira',
                      blocked: opened),
                  _MockTile('Email 3 — Receipt #4421', 'From: Store',
                      blocked: opened),
                  Spacer(),
                  _MockFab(blocked: opened),
                  SizedBox(height: 14),
                ],
              ),
              if (opened) _MockBarrier(),
              if (opened)
                Center(
                  child: _MockDialog(),
                ),
              Positioned(
                left: 12,
                top: 12,
                child: _StateBadge(opened: opened),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StateBadge extends StatelessWidget {
  const _StateBadge({required this.opened});
  final bool opened;

  @override
  Widget build(BuildContext context) {
    final Color tone = opened ? _kBad : _kGood;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            opened ? Icons.layers : Icons.check_circle_outline,
            color: tone,
            size: 12,
          ),
          SizedBox(width: 4),
          Text(
            opened ? 'Modal opened' : 'Modal closed',
            style: TextStyle(
              color: tone,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockAppBar extends StatelessWidget {
  const _MockAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _kPaperWarm,
        border: Border(bottom: BorderSide(color: _kRule)),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Icon(Icons.menu, color: _kInk, size: 18),
          SizedBox(width: 10),
          Text(
            'Inbox',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Icon(Icons.search, color: _kInkSoft, size: 18),
          SizedBox(width: 12),
          Icon(Icons.account_circle, color: _kInkSoft, size: 20),
        ],
      ),
    );
  }
}

class _MockTile extends StatelessWidget {
  const _MockTile(this.title, this.subtitle, {required this.blocked});
  final String title;
  final String subtitle;
  final bool blocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _kRule)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.mail_outline, size: 16, color: _kAccent),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _kInkMute,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          _SemanticTag(blocked: blocked),
        ],
      ),
    );
  }
}

class _SemanticTag extends StatelessWidget {
  const _SemanticTag({required this.blocked});
  final bool blocked;

  @override
  Widget build(BuildContext context) {
    final Color tone = blocked ? _kBad : _kGood;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
      ),
      child: Text(
        blocked ? 'a11y: hidden' : 'a11y: read',
        style: TextStyle(
          color: tone,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _MockFab extends StatelessWidget {
  const _MockFab({required this.blocked});
  final bool blocked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_kAccent, _kAccentAlt],
              ),
              borderRadius: BorderRadius.circular(999),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kAccent.withValues(alpha: 0.30),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.edit, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  'Compose',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 8),
                _SemanticTag(blocked: blocked),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockBarrier extends StatelessWidget {
  const _MockBarrier();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.45),
    );
  }
}

class _MockDialog extends StatelessWidget {
  const _MockDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.20),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: _kWarn, size: 18),
              SizedBox(width: 6),
              Text(
                'Delete this draft?',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'This action cannot be undone. The draft will be removed '
            'from your account immediately.',
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 12,
              height: 1.45,
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _DialogButton(label: 'Cancel', tone: _kInkSoft, filled: false),
              SizedBox(width: 8),
              _DialogButton(label: 'Delete', tone: _kBad, filled: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.tone,
    required this.filled,
  });
  final String label;
  final Color tone;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? tone : tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? Colors.white : tone,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. Drawer mock section.
// ---------------------------------------------------------------------------

class _DrawerMockSection extends StatelessWidget {
  const _DrawerMockSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Drawer',
      title: 'Annotated drawer mock',
      subtitle:
          'A common place BlockSemantics matters: an open Drawer. Without '
          'it, screen readers can swipe over to the page content behind '
          'the drawer and read it. With it, only the drawer items are '
          'reachable until the drawer closes.',
      eyebrowColor: _kInfo,
      child: Column(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _kRule),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _MockAppBar(),
                        _MockBehindRow(label: 'Inbox · Heading', blocked: true),
                        _MockBehindRow(label: 'Email — Mira', blocked: true),
                        _MockBehindRow(
                            label: 'Email — Anders', blocked: true),
                        _MockBehindRow(
                            label: 'Email — Receipt', blocked: true),
                        _MockBehindRow(label: 'Bottom nav', blocked: true),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  left: 240,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.35),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: 240,
                  child: _DrawerPanel(),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: _DrawerLegend(),
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _CardLite(
                  title: 'Inside the drawer',
                  body:
                      'Drawer items remain in the semantics tree because '
                      'they are painted after the BlockSemantics curtain. '
                      'A screen reader can focus them as expected.',
                  accent: _kGood,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _CardLite(
                  title: 'Behind the drawer',
                  body:
                      'Inbox items are painted before the drawer. '
                      'BlockSemantics removes them from the semantics '
                      'tree until the drawer closes.',
                  accent: _kBad,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MockBehindRow extends StatelessWidget {
  const _MockBehindRow({required this.label, required this.blocked});
  final String label;
  final bool blocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: _kRule)),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.inbox_outlined, size: 14, color: _kInkMute),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: _kInkSoft, fontSize: 12),
            ),
          ),
          _SemanticTag(blocked: blocked),
        ],
      ),
    );
  }
}

class _DrawerPanel extends StatelessWidget {
  const _DrawerPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFFFFFBF5),
            Color(0xFFFFF1DD),
          ],
        ),
        border: Border(right: BorderSide(color: _kRule)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: _kAccent.withValues(alpha: 0.18),
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: _kAccent,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mira Lemos',
                      style: TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'mira@studio.example',
                      style: TextStyle(
                        color: _kInkMute,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: _kRule, height: 1),
          _DrawerItem('Inbox', Icons.inbox, blocked: false),
          _DrawerItem('Starred', Icons.star_outline, blocked: false),
          _DrawerItem('Sent', Icons.send_outlined, blocked: false),
          _DrawerItem('Drafts', Icons.drafts_outlined, blocked: false),
          _DrawerItem('Trash', Icons.delete_outline, blocked: false),
          Spacer(),
          _DrawerItem('Settings', Icons.settings_outlined, blocked: false),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem(this.label, this.icon, {required this.blocked});
  final String label;
  final IconData icon;
  final bool blocked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14, color: _kInkSoft),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          _SemanticTag(blocked: blocked),
        ],
      ),
    );
  }
}

class _DrawerLegend extends StatelessWidget {
  const _DrawerLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kRule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Annotation legend',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 6),
          _SemanticTag(blocked: false),
          SizedBox(height: 4),
          _SemanticTag(blocked: true),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. Comparison table section.
// ---------------------------------------------------------------------------

class _ComparisonTableSection extends StatelessWidget {
  const _ComparisonTableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Comparison',
      title: 'BlockSemantics vs neighbors',
      subtitle:
          'BlockSemantics is one of several widgets that manipulate the '
          'semantics tree. Understanding the difference is critical to '
          'building correct accessibility.',
      eyebrowColor: _kWarn,
      child: Column(
        children: <Widget>[
          _CompareRow(
            header: true,
            cells: <String>[
              'Widget',
              'Scope',
              'Visual effect',
              'Use case',
            ],
          ),
          _CompareRow(
            cells: <String>[
              'BlockSemantics',
              'Everything painted before it',
              'None',
              'Modal barriers, drawers, dialogs',
            ],
          ),
          _CompareRow(
            cells: <String>[
              'ExcludeSemantics',
              'Descendants only',
              'None',
              'Decorative widgets that should not be announced',
            ],
          ),
          _CompareRow(
            cells: <String>[
              'MergeSemantics',
              'Descendants only',
              'None',
              'Composite widgets that should be one semantics node',
            ],
          ),
          _CompareRow(
            cells: <String>[
              'Semantics(excludeSemantics: true)',
              'Descendants only',
              'None',
              'Same as ExcludeSemantics but with custom annotations',
            ],
          ),
          _CompareRow(
            cells: <String>[
              'IgnorePointer',
              'Pointer events (not semantics by default)',
              'None',
              'Blocking touch input — different concern',
            ],
          ),
          _CompareRow(
            cells: <String>[
              'Visibility(visible: false)',
              'Both rendering and semantics',
              'Hidden',
              'Conditionally hide a subtree entirely',
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kWarn.withValues(alpha: 0.10),
                  _kAccent.withValues(alpha: 0.10),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kWarn.withValues(alpha: 0.30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Rule of thumb',
                  style: TextStyle(
                    color: _kWarn,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'If you want to hide a single subtree, reach for '
                  'ExcludeSemantics. If you want to hide everything else '
                  'on the screen because a modal is on top, reach for '
                  'BlockSemantics. The scope is the deciding factor.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({required this.cells, this.header = false});
  final List<String> cells;
  final bool header;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: header ? _kAccent.withValues(alpha: 0.08) : Colors.white,
        border: Border(bottom: BorderSide(color: _kRule)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < cells.length; i++)
            Expanded(
              flex: i == 0 ? 3 : 4,
              child: Text(
                cells[i],
                style: TextStyle(
                  color: header ? _kAccent : _kInkSoft,
                  fontSize: 12.5,
                  fontWeight: header ? FontWeight.w800 : FontWeight.w600,
                  letterSpacing: header ? 0.4 : 0,
                  fontFamily: i == 0 ? 'monospace' : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 7. Paint order rule diagram section.
// ---------------------------------------------------------------------------

class _PaintOrderRuleSection extends StatelessWidget {
  const _PaintOrderRuleSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Paint order',
      title: 'The rule: paint order, not tree order',
      subtitle:
          'BlockSemantics is sensitive to paint order, which is usually — '
          'but not always — the same as widget tree order. Stacks, '
          'OverlayEntries, and CustomMultiChildLayout can change paint '
          'order without changing tree order.',
      eyebrowColor: _kBad,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFFFF5F4),
                  Color(0xFFFFE9E6),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBad.withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _PaintLayer(label: 'Layer 1 · Scaffold body', color: _kInfo),
                _ArrowDown(),
                _PaintLayer(label: 'Layer 2 · ListView tiles', color: _kInfo),
                _ArrowDown(),
                _PaintLayer(
                  label: 'Layer 3 · BlockSemantics ◀ curtain',
                  color: _kAccent,
                  highlight: true,
                ),
                _ArrowDown(),
                _PaintLayer(
                  label: 'Layer 4 · ModalBarrier',
                  color: _kInfo,
                ),
                _ArrowDown(),
                _PaintLayer(
                  label: 'Layer 5 · Dialog content',
                  color: _kGood,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _CardLite(
                  title: 'Above the curtain',
                  body:
                      'Layers 1 and 2 painted before the curtain — they '
                      'are removed from the semantics tree.',
                  accent: _kBad,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _CardLite(
                  title: 'Below the curtain',
                  body:
                      'Layers 4 and 5 painted after the curtain — they '
                      'remain in the semantics tree as normal.',
                  accent: _kGood,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaintLayer extends StatelessWidget {
  const _PaintLayer({
    required this.label,
    required this.color,
    this.highlight = false,
  });
  final String label;
  final Color color;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: highlight ? color.withValues(alpha: 0.18) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: highlight ? 0.55 : 0.30),
          width: highlight ? 2 : 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            highlight ? Icons.block_flipped : Icons.layers_outlined,
            size: 16,
            color: color,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: highlight ? color : _kInkSoft,
              fontWeight: highlight ? FontWeight.w800 : FontWeight.w700,
              fontSize: 13,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowDown extends StatelessWidget {
  const _ArrowDown();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Icon(Icons.arrow_downward, color: _kInkMute, size: 14),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. Code snippet gallery section.
// ---------------------------------------------------------------------------

class _CodeSnippetGallerySection extends StatelessWidget {
  const _CodeSnippetGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Recipes',
      title: 'Code snippet gallery',
      subtitle:
          'Real, hand-typed examples covering the most common ways to '
          'reach for BlockSemantics. Copy them into your own modal '
          'experiences as a starting point.',
      eyebrowColor: _kAccent,
      child: Column(
        children: <Widget>[
          _SnippetCard(
            title: 'Manual modal barrier with BlockSemantics',
            body:
                'Use ModalBarrier together with BlockSemantics in an '
                'Overlay entry to build your own modal-like surface.',
            code: 'OverlayEntry(\n'
                '  builder: (BuildContext context) {\n'
                '    return BlockSemantics(\n'
                '      blocking: true,\n'
                '      child: ModalBarrier(\n'
                '        color: Colors.black.withOpacity(0.4),\n'
                '        dismissible: true,\n'
                '        semanticsLabel: "Dismiss",\n'
                '      ),\n'
                '    );\n'
                '  },\n'
                ');',
          ),
          SizedBox(height: 12),
          _SnippetCard(
            title: 'Custom modal panel above app content',
            body:
                'Stack a BlockSemantics + ModalBarrier behind a panel. '
                'Everything painted before BlockSemantics is hidden from '
                'screen readers.',
            code: 'Stack(\n'
                '  children: <Widget>[\n'
                '    PageContent(),\n'
                '    if (isModalOpen) ...<Widget>[\n'
                '      BlockSemantics(\n'
                '        child: ModalBarrier(color: Colors.black54),\n'
                '      ),\n'
                '      Center(child: MyCustomPanel()),\n'
                '    ],\n'
                '  ],\n'
                ');',
          ),
          SizedBox(height: 12),
          _SnippetCard(
            title: 'Conditional blocking based on app state',
            body:
                'Toggle blocking via the constructor argument. When false, '
                'BlockSemantics becomes a pure passthrough.',
            code: 'BlockSemantics(\n'
                '  blocking: showTutorialOverlay,\n'
                '  child: TutorialOverlay(),\n'
                ');',
          ),
          SizedBox(height: 12),
          _SnippetCard(
            title: 'Drawer-like surface, manually built',
            body:
                'When building a non-standard drawer, wrap the barrier '
                'plus the panel in a Stack and use BlockSemantics to hide '
                'the content behind.',
            code: 'Stack(\n'
                '  children: <Widget>[\n'
                '    Scaffold(body: AppBody()),\n'
                '    if (drawerOpen) ...<Widget>[\n'
                '      BlockSemantics(child: ModalBarrier(color: Colors.black45)),\n'
                '      Align(\n'
                '        alignment: Alignment.centerLeft,\n'
                '        child: SizedBox(width: 280, child: DrawerPanel()),\n'
                '      ),\n'
                '    ],\n'
                '  ],\n'
                ');',
          ),
          SizedBox(height: 12),
          _SnippetCard(
            title: 'Wrapping a route widget',
            body:
                'Route transitions can also use BlockSemantics to prevent '
                'the previous route from leaking into the semantics tree '
                'during transitions.',
            code: 'PageRouteBuilder(\n'
                '  pageBuilder: (context, _, __) => BlockSemantics(\n'
                '    child: MyDestinationPage(),\n'
                '  ),\n'
                ');',
          ),
          SizedBox(height: 12),
          _SnippetCard(
            title: 'Disabling blocking with a falsy flag',
            body:
                'A common pattern for testability: keep the widget in '
                'place but toggle off blocking in tests that need the '
                'background semantics.',
            code: 'BlockSemantics(\n'
                '  blocking: !widgetTestMode,\n'
                '  child: Modal(),\n'
                ');',
          ),
        ],
      ),
    );
  }
}

class _SnippetCard extends StatelessWidget {
  const _SnippetCard({
    required this.title,
    required this.body,
    required this.code,
  });
  final String title;
  final String body;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kRule),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.code, size: 16, color: _kAccent),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.45),
          ),
          SizedBox(height: 10),
          _MonoBlock(code),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 9. Pitfalls section.
// ---------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Pitfalls',
      title: 'Common ways teams trip over BlockSemantics',
      subtitle:
          'BlockSemantics is small and well-behaved, but its interaction '
          'with paint order, overlays, and the rest of the semantics '
          'stack catches teams off guard. Here are the patterns to '
          'recognize and fix.',
      eyebrowColor: _kBad,
      child: Column(
        children: <Widget>[
          _PitfallCard(
            number: '01',
            title: 'Placing BlockSemantics too high in the tree',
            body:
                'If BlockSemantics is at the top of the tree (e.g. wrapping '
                'the entire MaterialApp), nothing is painted before it and '
                'it has no effect. Worse, if it is above the modal but '
                'wrapping the entire app rather than as part of the '
                'overlay, you can accidentally hide everything.',
            example:
                'BAD:  BlockSemantics( child: MaterialApp(...) );\n'
                'GOOD: Stack([ PageContent(), BlockSemantics(child: Barrier()) ]);',
          ),
          _PitfallCard(
            number: '02',
            title: 'Misunderstanding "painted before"',
            body:
                'Paint order is not always intuitive. In a Stack, widgets '
                'are painted in the order they appear in children — the '
                'last child is on top visually but is also painted last. '
                'BlockSemantics belongs near the modal child, not at the '
                'top of the stack.',
            example: 'Stack(\n'
                '  children: <Widget>[\n'
                '    PageContent(),     // painted first\n'
                '    BlockSemantics(    // painted next — hides PageContent\n'
                '      child: ModalBarrier(),\n'
                '    ),\n'
                '    DialogPanel(),     // painted last — visible to a11y\n'
                '  ],\n'
                ');',
          ),
          _PitfallCard(
            number: '03',
            title: 'Forgetting to remove BlockSemantics when the modal closes',
            body:
                'If BlockSemantics is still active after the modal is '
                'dismissed, the user is locked out of the page. Always '
                'tie its lifetime to the modal lifetime, e.g. via the '
                'route or the overlay entry.',
            example:
                'Make sure your modal route or overlay entry that owns '
                'BlockSemantics is removed when the modal closes. Use '
                'Navigator.pop() or removeOverlayEntry() reliably.',
          ),
          _PitfallCard(
            number: '04',
            title: 'Stacking multiple BlockSemantics needlessly',
            body:
                'You only need one BlockSemantics per modal layer. '
                'Adding multiple does not produce stronger blocking; it '
                'just complicates the tree and confuses reviewers.',
            example:
                'BAD:  BlockSemantics( child: BlockSemantics( child: X() ));\n'
                'GOOD: BlockSemantics( child: X() );',
          ),
          _PitfallCard(
            number: '05',
            title: 'Confusing BlockSemantics with IgnorePointer',
            body:
                'BlockSemantics does not stop pointer events. If your '
                'modal needs to swallow taps from the page behind, use '
                'ModalBarrier or IgnorePointer in addition.',
            example: 'Stack(\n'
                '  children: <Widget>[\n'
                '    IgnorePointer(ignoring: true, child: BackgroundContent()),\n'
                '    BlockSemantics(child: ModalBarrier()),\n'
                '    DialogPanel(),\n'
                '  ],\n'
                ');',
          ),
          _PitfallCard(
            number: '06',
            title: 'Skipping accessibility QA',
            body:
                'BlockSemantics is invisible to sighted users. The only '
                'way to verify its behavior is to test with VoiceOver, '
                'TalkBack, or the Flutter semantics debugger.',
            example:
                'Run "flutter run" then enable the Semantics debugger '
                'from the inspector. Confirm that modal content is the '
                'only thing readable when the modal is open.',
          ),
          _PitfallCard(
            number: '07',
            title: 'Relying on BlockSemantics for visual occlusion',
            body:
                'BlockSemantics changes nothing visual. If a designer '
                'asks you to "dim the background", you need a '
                'ModalBarrier or a colored Container with opacity — not '
                'BlockSemantics.',
            example: 'Use ModalBarrier(color: Colors.black54) alongside it.',
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.body,
    required this.example,
  });
  final String number;
  final String title;
  final String body;
  final String example;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kRule),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kBad.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kBad.withValues(alpha: 0.18),
                  _kWarn.withValues(alpha: 0.16),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kBad.withValues(alpha: 0.30)),
            ),
            child: Text(
              number,
              style: TextStyle(
                color: _kBad,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 10),
                _MonoBlock(example, caption: 'example'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 10. Best practices section.
// ---------------------------------------------------------------------------

class _BestPracticesSection extends StatelessWidget {
  const _BestPracticesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Best practices',
      title: 'How to use BlockSemantics well',
      subtitle:
          'The pattern collection that experienced Flutter accessibility '
          'engineers reach for. Each one is a small habit, but together '
          'they make modal experiences feel correct to every user.',
      eyebrowColor: _kGood,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BestPracticeCard(
                  title: 'Pair it with a barrier',
                  body:
                      'Visual users see a barrier; assistive technology '
                      'users get BlockSemantics. Both should appear and '
                      'disappear together.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _BestPracticeCard(
                  title: 'Tie its lifetime to the modal',
                  body:
                      'BlockSemantics should not outlive the modal that '
                      'caused it. Bind it to the OverlayEntry or route.',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BestPracticeCard(
                  title: 'Avoid wrapping the whole app',
                  body:
                      'Place it as close to the modal as possible. Wider '
                      'wrapping makes paint order harder to reason about.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _BestPracticeCard(
                  title: 'Use the existing modals first',
                  body:
                      'showDialog, Drawer, ModalBottomSheet, etc. already '
                      'include BlockSemantics. Reach for it manually only '
                      'when you are building a custom modal surface.',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BestPracticeCard(
                  title: 'Test with semantics debugger',
                  body:
                      'Turn on "Show Semantics" in the inspector and '
                      'verify that opening the modal removes the page '
                      'nodes.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _BestPracticeCard(
                  title: 'Document the assumption',
                  body:
                      'A comment near BlockSemantics that explains its '
                      'role is appreciated. It is invisible code; the '
                      'comment is the only sign for readers.',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BestPracticeCard(
                  title: 'Combine with FocusScope.absorb',
                  body:
                      'For keyboard accessibility, pair BlockSemantics '
                      'with a FocusScope set to absorb. Together they '
                      'cover screen readers and keyboard nav.',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _BestPracticeCard(
                  title: 'Verify on both platforms',
                  body:
                      'VoiceOver on iOS and TalkBack on Android can '
                      'behave subtly differently. Always test both.',
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kGood.withValues(alpha: 0.10),
                  _kAccentAlt.withValues(alpha: 0.10),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kGood.withValues(alpha: 0.30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.verified_outlined, color: _kGood, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Checklist before merging a custom modal',
                      style: TextStyle(
                        color: _kGood,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _Bullet(
                  'A BlockSemantics is in the overlay or stack of the modal.',
                ),
                _Bullet(
                  'It is positioned between the page content and the modal '
                  'surface in paint order.',
                ),
                _Bullet(
                  'Closing the modal removes BlockSemantics from the tree.',
                ),
                _Bullet(
                  'Background pointer events are absorbed (ModalBarrier or '
                  'IgnorePointer).',
                ),
                _Bullet(
                  'Focus is moved into the modal and restored when the '
                  'modal closes.',
                ),
                _Bullet(
                  'Verified with VoiceOver, TalkBack, and the Semantics '
                  'inspector.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BestPracticeCard extends StatelessWidget {
  const _BestPracticeCard({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kGood.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGood.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle_outline, color: _kGood, size: 14),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(color: _kInkSoft, fontSize: 12.5, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 11. Footer section.
// ---------------------------------------------------------------------------

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(28, 24, 28, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF101828),
            Color(0xFF1D2939),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.30),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.bookmark_outline,
                color: Colors.white.withValues(alpha: 0.85),
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'BlockSemantics — recap',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'BlockSemantics is the small but essential widget that keeps '
            'screen readers from leaking into the page beneath a modal. '
            'It changes no pixels, costs essentially nothing to rebuild, '
            'and is already built into showDialog, Drawer, and '
            'ModalBottomSheet. When you build a custom modal surface, '
            'reach for it explicitly — your assistive-technology users '
            'will thank you.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.86),
              fontSize: 13,
              height: 1.6,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _FooterPill('Accessibility', _kAccent),
              _FooterPill('Modal patterns', _kAccentAlt),
              _FooterPill('Paint order', _kInfo),
              _FooterPill('Semantics tree', _kGood),
              _FooterPill('Drawer', _kWarn),
              _FooterPill('Dialog', _kBad),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.20),
              ),
            ),
            child: Text(
              'Demo file: blocksemantics_test.dart  ·  fully static  ·  '
              'no Timer / Future / Stream / setState',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.70),
                fontSize: 11,
                fontFamily: 'monospace',
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterPill extends StatelessWidget {
  const _FooterPill(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.95),
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
