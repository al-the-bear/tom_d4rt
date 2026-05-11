// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// AbstractNode Deep Demo
// =============================================================================
//
// AbstractNode is the legacy base class in flutter/foundation that historically
// underpinned tree-structured objects such as RenderObject, SemanticsNode, and
// Layer. It provides the four pillars of any framework tree:
//
//   1. parent       — reference to the owning node, or null if this is a root.
//   2. depth        — distance from the root, used for ordering traversals.
//   3. owner        — the "pipeline" object that coordinates attached nodes.
//   4. attached     — a boolean that reflects whether owner is non-null.
//
// AbstractNode itself does not perform any rendering, layout, or hit testing.
// It is purely a bookkeeping skeleton. Subclasses layer their own semantics on
// top of it (RenderObject adds layout/paint, Layer adds compositing, etc.).
//
// This file is a fully-static visual reference for AbstractNode. It does NOT
// invoke any AbstractNode APIs at runtime — the goal is documentation, not
// execution. Every section below is a StatelessWidget that renders annotated
// diagrams, tables, and bullet lists describing one facet of the class.
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AbstractNode Deep Demo',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _HeroHeaderSection(),
            SizedBox(height: 32),
            _AnatomyDiagramSection(),
            SizedBox(height: 32),
            _PropertyReferenceSection(),
            SizedBox(height: 32),
            _MethodReferenceSection(),
            SizedBox(height: 32),
            _LifecycleStateMachineSection(),
            SizedBox(height: 32),
            _OwnerConceptSection(),
            SizedBox(height: 32),
            _SubclassTableSection(),
            SizedBox(height: 32),
            _DepthRecomputationWalkthroughSection(),
            SizedBox(height: 32),
            _PitfallsSection(),
            SizedBox(height: 32),
            _ApiTimelineSection(),
            SizedBox(height: 32),
            _FooterSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — Hero Header
// =============================================================================
class _HeroHeaderSection extends StatelessWidget {
  const _HeroHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF1A237E),
            const Color(0xFF311B92),
            const Color(0xFF4A148C).withValues(alpha: 0.92),
          ],
          stops: const <double>[0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                child: const Text(
                  'flutter/foundation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'foundational class',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'AbstractNode',
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'The tree-bookkeeping skeleton beneath the Flutter framework',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              _HeroBadge(label: 'depth', value: 'int >= 0'),
              _HeroBadge(label: 'owner', value: 'Object?'),
              _HeroBadge(label: 'parent', value: 'AbstractNode?'),
              _HeroBadge(label: 'attached', value: 'bool'),
              _HeroBadge(label: 'attach', value: 'method'),
              _HeroBadge(label: 'detach', value: 'method'),
              _HeroBadge(label: 'adoptChild', value: 'method'),
              _HeroBadge(label: 'dropChild', value: 'method'),
              _HeroBadge(label: 'redepthChild', value: 'method'),
              _HeroBadge(label: 'redepthChildren', value: 'method'),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: Text(
              'AbstractNode is intentionally minimal. It does not paint, lay out, '
              'or hit-test. It tracks parent/child relationships, an ascending '
              'depth value, and an owner reference so that subclasses can build '
              'rich tree algorithms on top of a single shared protocol.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 1,
            height: 14,
            color: Colors.white.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SHARED — Section Shell
// =============================================================================
class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: const Color(0xFFE0E4EC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  accent.withValues(alpha: 0.18),
                  accent.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(color: accent.withValues(alpha: 0.3)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 10,
                      height: 28,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: accent,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: accent.withValues(alpha: 0.75),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items, required this.accent});

  final List<String> items;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final String item in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 6, right: 10),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF37474F),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// =============================================================================
// SECTION 2 — Anatomy Diagram
// =============================================================================
class _AnatomyDiagramSection extends StatelessWidget {
  const _AnatomyDiagramSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Anatomy of an AbstractNode Tree',
      subtitle: 'parent <-> child links and the depth invariant',
      accent: const Color(0xFF1976D2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  const Color(0xFFE3F2FD),
                  const Color(0xFFBBDEFB).withValues(alpha: 0.55),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF90CAF9)),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    _TreeNodeBox(
                      label: 'root',
                      depth: 0,
                      color: Color(0xFF1565C0),
                      detail: 'parent: null',
                    ),
                  ],
                ),
                const _VerticalConnector(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    _TreeNodeBox(
                      label: 'child A',
                      depth: 1,
                      color: Color(0xFF1976D2),
                      detail: 'parent: root',
                    ),
                    SizedBox(width: 24),
                    _TreeNodeBox(
                      label: 'child B',
                      depth: 1,
                      color: Color(0xFF1976D2),
                      detail: 'parent: root',
                    ),
                    SizedBox(width: 24),
                    _TreeNodeBox(
                      label: 'child C',
                      depth: 1,
                      color: Color(0xFF1976D2),
                      detail: 'parent: root',
                    ),
                  ],
                ),
                const _VerticalConnector(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    _TreeNodeBox(
                      label: 'grandchild A1',
                      depth: 2,
                      color: Color(0xFF42A5F5),
                      detail: 'parent: A',
                    ),
                    SizedBox(width: 16),
                    _TreeNodeBox(
                      label: 'grandchild A2',
                      depth: 2,
                      color: Color(0xFF42A5F5),
                      detail: 'parent: A',
                    ),
                    SizedBox(width: 16),
                    _TreeNodeBox(
                      label: 'grandchild B1',
                      depth: 2,
                      color: Color(0xFF42A5F5),
                      detail: 'parent: B',
                    ),
                    SizedBox(width: 16),
                    _TreeNodeBox(
                      label: 'grandchild C1',
                      depth: 2,
                      color: Color(0xFF42A5F5),
                      detail: 'parent: C',
                    ),
                  ],
                ),
                const _VerticalConnector(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    _TreeNodeBox(
                      label: 'leaf A1a',
                      depth: 3,
                      color: Color(0xFF64B5F6),
                      detail: 'parent: A1',
                    ),
                    SizedBox(width: 16),
                    _TreeNodeBox(
                      label: 'leaf B1a',
                      depth: 3,
                      color: Color(0xFF64B5F6),
                      detail: 'parent: B1',
                    ),
                    SizedBox(width: 16),
                    _TreeNodeBox(
                      label: 'leaf C1a',
                      depth: 3,
                      color: Color(0xFF64B5F6),
                      detail: 'parent: C1',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _BulletList(
            items: const <String>[
              'Each node has at most one parent. The root has parent == null.',
              'depth is strictly greater than the parent\'s depth value.',
              'depth is not necessarily parent.depth + 1; it just must be greater.',
              'redepthChild() enforces the strict ordering invariant.',
              'owner propagates downward: when root attaches, descendants attach.',
            ],
            accent: const Color(0xFF1976D2),
          ),
        ],
      ),
    );
  }
}

class _TreeNodeBox extends StatelessWidget {
  const _TreeNodeBox({
    required this.label,
    required this.depth,
    required this.color,
    required this.detail,
  });

  final String label;
  final int depth;
  final Color color;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'depth: $depth',
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF455A64),
              fontFamily: 'monospace',
            ),
          ),
          Text(
            detail,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF607D8B),
              fontFamily: 'monospace',
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _VerticalConnector extends StatelessWidget {
  const _VerticalConnector({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          width: 2,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                const Color(0xFF1976D2).withValues(alpha: 0.4),
                const Color(0xFF1976D2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Property Reference
// =============================================================================
class _PropertyReferenceSection extends StatelessWidget {
  const _PropertyReferenceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Property Reference',
      subtitle: 'Every observable field on AbstractNode',
      accent: const Color(0xFF388E3C),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const <Widget>[
          _PropertyCard(
            name: 'depth',
            type: 'int',
            access: 'final get; @protected set',
            tagline: 'Distance-from-root proxy',
            description:
                'Used by traversal algorithms to ensure that a parent is '
                'processed before its descendants. AbstractNode itself never '
                'sets depth automatically beyond 0; subclasses call '
                'redepthChild() during adoption.',
            color: Color(0xFF388E3C),
          ),
          _PropertyCard(
            name: 'owner',
            type: 'Object?',
            access: 'get',
            tagline: 'The pipeline / owner reference',
            description:
                'Non-null while attached. RenderObject narrows this to '
                'PipelineOwner. Layer narrows it to a Compositor-style owner. '
                'AbstractNode keeps the type Object so each subclass picks '
                'its own concrete owner type via attach().',
            color: Color(0xFF388E3C),
          ),
          _PropertyCard(
            name: 'parent',
            type: 'AbstractNode?',
            access: 'get; @protected set via adoptChild',
            tagline: 'Up-link in the tree',
            description:
                'Set by adoptChild() and cleared by dropChild(). Direct '
                'assignment is intentionally inaccessible to enforce that '
                'depth recomputation and attach/detach hooks always fire.',
            color: Color(0xFF388E3C),
          ),
          _PropertyCard(
            name: 'attached',
            type: 'bool',
            access: 'get',
            tagline: 'Reflects owner != null',
            description:
                'A convenience boolean derived from owner. Subclasses MUST '
                'NOT override attached; instead they override attach() and '
                'detach() to perform any per-node setup or teardown.',
            color: Color(0xFF388E3C),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({
    required this.name,
    required this.type,
    required this.access,
    required this.tagline,
    required this.description,
    required this.color,
  });

  final String name;
  final String type;
  final String access;
  final String tagline;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.06),
            color.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                type,
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            tagline,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            access,
            style: TextStyle(
              color: color.withValues(alpha: 0.85),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF455A64),
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Method Reference
// =============================================================================
class _MethodReferenceSection extends StatelessWidget {
  const _MethodReferenceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Method Reference',
      subtitle: 'Lifecycle and tree-mutation entry points',
      accent: const Color(0xFFE65100),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const <Widget>[
          _MethodCard(
            signature: 'void attach(covariant Object owner)',
            tagline: 'Bind this node to a pipeline',
            sideEffects: <String>[
              'Asserts that the node was previously detached.',
              'Sets _owner to the provided owner argument.',
              'Subclasses must call super.attach(owner) first.',
              'Subclasses propagate attach() to their children.',
              'After this call, attached == true.',
            ],
            color: Color(0xFFE65100),
          ),
          _MethodCard(
            signature: 'void detach()',
            tagline: 'Unbind this node from its pipeline',
            sideEffects: <String>[
              'Asserts that the node is currently attached.',
              'Clears _owner to null.',
              'Subclasses propagate detach() to their children.',
              'Subclasses must call super.detach() at the end.',
              'After this call, attached == false.',
            ],
            color: Color(0xFFE65100),
          ),
          _MethodCard(
            signature: 'void adoptChild(covariant AbstractNode child)',
            tagline: 'Make a node our child',
            sideEffects: <String>[
              'Asserts child.parent == null before adoption.',
              'Sets child._parent = this.',
              'Calls redepthChild(child) to enforce depth invariant.',
              'If this is attached, calls child.attach(owner).',
              'Must be called once per child during ownership transfer.',
            ],
            color: Color(0xFFE65100),
          ),
          _MethodCard(
            signature: 'void dropChild(covariant AbstractNode child)',
            tagline: 'Release a previously adopted child',
            sideEffects: <String>[
              'Asserts child.parent == this before dropping.',
              'Calls child.detach() if currently attached.',
              'Clears child._parent to null.',
              'Does NOT delete the child — it just disowns it.',
              'The dropped child may then be adopted elsewhere.',
            ],
            color: Color(0xFFE65100),
          ),
          _MethodCard(
            signature: 'void redepthChild(covariant AbstractNode child)',
            tagline: 'Maintain the strictly-increasing depth invariant',
            sideEffects: <String>[
              'If child.depth <= this.depth, sets child._depth = this.depth + 1.',
              'Recursively calls child.redepthChildren().',
              'Idempotent — safe to call multiple times.',
              'Called automatically by adoptChild().',
              'Subclasses may override to skip non-tree children.',
            ],
            color: Color(0xFFE65100),
          ),
          _MethodCard(
            signature: 'void redepthChildren()',
            tagline: 'Recompute depth for every direct child',
            sideEffects: <String>[
              'Default impl is a no-op; AbstractNode has no child list.',
              'Subclasses override to walk visitChildren or visitChildrenForSemantics.',
              'Triggered after a node\'s own depth changes.',
              'Cheap when the tree is already consistent.',
              'Critical when re-parenting deep subtrees.',
            ],
            color: Color(0xFFE65100),
          ),
        ],
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({
    required this.signature,
    required this.tagline,
    required this.sideEffects,
    required this.color,
  });

  final String signature;
  final String tagline;
  final List<String> sideEffects;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  color.withValues(alpha: 0.18),
                  color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              signature,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tagline,
            style: const TextStyle(
              color: Color(0xFF263238),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          for (final String effect in sideEffects)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.east, size: 14, color: color),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      effect,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF455A64),
                        height: 1.45,
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
}

// =============================================================================
// SECTION 5 — Lifecycle State Machine
// =============================================================================
class _LifecycleStateMachineSection extends StatelessWidget {
  const _LifecycleStateMachineSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Lifecycle State Machine',
      subtitle: 'Detached <-> Attached',
      accent: const Color(0xFF6A1B9A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFFF3E5F5),
                  const Color(0xFFE1BEE7).withValues(alpha: 0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFCE93D8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                _StateBox(
                  label: 'Detached',
                  description: 'owner == null\nattached == false',
                  color: Color(0xFF8E24AA),
                ),
                _TransitionArrow(
                  topLabel: 'attach(owner)',
                  bottomLabel: 'detach()',
                  color: Color(0xFF6A1B9A),
                ),
                _StateBox(
                  label: 'Attached',
                  description: 'owner != null\nattached == true',
                  color: Color(0xFF4A148C),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: _StateRule(
                  title: 'Entering Attached',
                  body:
                      'attach() must be called by the parent (during adoptChild) '
                      'or by the pipeline owner (for the root). Subclasses '
                      'forward attach() to children recursively.',
                  color: const Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StateRule(
                  title: 'Entering Detached',
                  body:
                      'detach() must be called before the node is dropped from '
                      'its parent or before its owner is disposed. The order '
                      'matters: detach children first, then super.detach().',
                  color: const Color(0xFF6A1B9A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFE082)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(Icons.warning_amber_rounded,
                    color: Color(0xFFF57F17), size: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Forgetting to call detach() before disposing the owner '
                    'leaks the node — its destructor never fires in modes that '
                    'depend on the lifecycle (e.g. SemanticsNode listeners).',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFE65100),
                      height: 1.5,
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
}

class _StateBox extends StatelessWidget {
  const _StateBox({
    required this.label,
    required this.description,
    required this.color,
  });

  final String label;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 3),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.adjust, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color.withValues(alpha: 0.85),
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransitionArrow extends StatelessWidget {
  const _TransitionArrow({
    required this.topLabel,
    required this.bottomLabel,
    required this.color,
  });

  final String topLabel;
  final String bottomLabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              topLabel,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        color.withValues(alpha: 0.3),
                        color,
                      ],
                    ),
                  ),
                ),
              ),
              Icon(Icons.arrow_right, color: color, size: 28),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              Icon(Icons.arrow_left, color: color, size: 28),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[
                        color,
                        color.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              bottomLabel,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StateRule extends StatelessWidget {
  const _StateRule({
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF455A64),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — Owner Concept (PipelineOwner analogy)
// =============================================================================
class _OwnerConceptSection extends StatelessWidget {
  const _OwnerConceptSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'The Owner Concept',
      subtitle: 'PipelineOwner as the canonical AbstractNode owner',
      accent: const Color(0xFF00838F),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFFE0F7FA),
                  const Color(0xFFB2EBF2).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF80DEEA)),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF006064),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFF006064)
                            .withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: const <Widget>[
                      Icon(Icons.hub, color: Colors.white, size: 28),
                      SizedBox(height: 6),
                      Text(
                        'PipelineOwner',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'owner reference for all attached descendants',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Icon(Icons.arrow_downward,
                    color: Color(0xFF006064), size: 28),
                const SizedBox(height: 16),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: const <Widget>[
                    _OwnerChip(label: 'root node', owned: true),
                    _OwnerChip(label: 'subtree node A', owned: true),
                    _OwnerChip(label: 'subtree node B', owned: true),
                    _OwnerChip(label: 'subtree node C', owned: true),
                    _OwnerChip(label: 'subtree node D', owned: true),
                    _OwnerChip(label: 'subtree node E', owned: true),
                    _OwnerChip(label: 'orphan F', owned: false),
                    _OwnerChip(label: 'orphan G', owned: false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _BulletList(
            items: const <String>[
              'There is exactly one owner per attached tree (a forest is unusual).',
              'Subclasses narrow the Object type to their concrete owner class.',
              'When the root attaches, every descendant in the subtree attaches.',
              'When the root detaches, every descendant detaches in reverse order.',
              'Orphan nodes (no parent, no owner) can still be queried locally.',
            ],
            accent: const Color(0xFF00838F),
          ),
        ],
      ),
    );
  }
}

class _OwnerChip extends StatelessWidget {
  const _OwnerChip({required this.label, required this.owned});

  final String label;
  final bool owned;

  @override
  Widget build(BuildContext context) {
    final Color base =
        owned ? const Color(0xFF00838F) : const Color(0xFFB0BEC5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: base, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            owned ? Icons.link : Icons.link_off,
            size: 14,
            color: base,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: base,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: base.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              owned ? 'attached' : 'detached',
              style: TextStyle(
                color: base,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — Subclass Table
// =============================================================================
class _SubclassTableSection extends StatelessWidget {
  const _SubclassTableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Common Subclasses',
      subtitle: 'What each subclass layers on top of AbstractNode',
      accent: const Color(0xFFAD1457),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF8BBD0)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    const Color(0xFFAD1457),
                    const Color(0xFF880E4F).withValues(alpha: 0.9),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Row(
                children: const <Widget>[
                  Expanded(
                      flex: 2,
                      child: _TableHeaderCell(label: 'Subclass')),
                  Expanded(
                      flex: 2,
                      child: _TableHeaderCell(label: 'Owner Type')),
                  Expanded(
                      flex: 3,
                      child: _TableHeaderCell(
                          label: 'Adds On Top Of AbstractNode')),
                  Expanded(
                      flex: 2,
                      child: _TableHeaderCell(label: 'Tree Direction')),
                ],
              ),
            ),
            _SubclassRow(
              name: 'RenderObject',
              owner: 'PipelineOwner',
              adds:
                  'Layout, paint, hit testing, semantics, intrinsic sizing, RTL handling.',
              direction: 'parent -> children',
              even: false,
            ),
            _SubclassRow(
              name: 'Layer',
              owner: 'Compositor',
              adds:
                  'Composited paint output; engine layer handle; scene building.',
              direction: 'firstChild ... lastChild',
              even: true,
            ),
            _SubclassRow(
              name: 'SemanticsNode',
              owner: 'SemanticsOwner',
              adds:
                  'Accessibility data: label, hint, actions, flags, tags, transform.',
              direction: 'parent -> children',
              even: false,
            ),
            _SubclassRow(
              name: 'PipelineOwner (uses)',
              owner: 'n/a',
              adds:
                  'Coordinates flushLayout, flushPaint, flushSemantics phases.',
              direction: 'forest of roots',
              even: true,
            ),
            _SubclassRow(
              name: 'RenderBox',
              owner: 'PipelineOwner',
              adds:
                  'Box protocol: 2D size, BoxConstraints, baselines, hit-test entries.',
              direction: 'parent -> children',
              even: false,
            ),
            _SubclassRow(
              name: 'RenderSliver',
              owner: 'PipelineOwner',
              adds:
                  'Sliver protocol: SliverConstraints/SliverGeometry, scroll-aware paint.',
              direction: 'parent -> children',
              even: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  const _TableHeaderCell({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 13,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SubclassRow extends StatelessWidget {
  const _SubclassRow({
    required this.name,
    required this.owner,
    required this.adds,
    required this.direction,
    required this.even,
  });

  final String name;
  final String owner;
  final String adds;
  final String direction;
  final bool even;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: even ? const Color(0xFFFCE4EC) : Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFF8BBD0)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFFAD1457),
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              owner,
              style: const TextStyle(
                color: Color(0xFF6A1B4D),
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              adds,
              style: const TextStyle(
                color: Color(0xFF263238),
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              direction,
              style: const TextStyle(
                color: Color(0xFF6A1B4D),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Depth Recomputation Walkthrough
// =============================================================================
class _DepthRecomputationWalkthroughSection extends StatelessWidget {
  const _DepthRecomputationWalkthroughSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Depth Recomputation Walkthrough',
      subtitle: 'How redepthChildren restores the invariant after re-parenting',
      accent: const Color(0xFF5D4037),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _WalkthroughStep(
            step: 1,
            title: 'Initial subtree (before re-parenting)',
            description:
                'Subtree S is rooted at node X with depth 2. Its descendants '
                'have depths 3, 4 and 5 — the strictly-increasing invariant '
                'holds.',
            beforeDepths: <int>[2, 3, 4, 5],
            afterDepths: <int>[2, 3, 4, 5],
            highlightIndex: -1,
            color: Color(0xFF5D4037),
          ),
          _WalkthroughStep(
            step: 2,
            title: 'X is re-parented under Y (depth 7)',
            description:
                'adoptChild(X) is called on Y. After Y\'s _parent assignment, '
                'redepthChild(X) bumps X.depth to 8 because Y.depth (7) >= '
                'X.depth (2).',
            beforeDepths: <int>[2, 3, 4, 5],
            afterDepths: <int>[8, 3, 4, 5],
            highlightIndex: 0,
            color: Color(0xFF5D4037),
          ),
          _WalkthroughStep(
            step: 3,
            title: 'X.redepthChildren() runs recursively',
            description:
                'X now redepths its own children. The first descendant had '
                'depth 3 but X.depth is 8, so it gets bumped to 9. The '
                'recursion continues downward.',
            beforeDepths: <int>[8, 3, 4, 5],
            afterDepths: <int>[8, 9, 4, 5],
            highlightIndex: 1,
            color: Color(0xFF5D4037),
          ),
          _WalkthroughStep(
            step: 4,
            title: 'All descendants restored',
            description:
                'The walk finishes once every descendant has a depth greater '
                'than its parent. The subtree is consistent again — note depths '
                'are not minimal, only strictly increasing.',
            beforeDepths: <int>[8, 9, 4, 5],
            afterDepths: <int>[8, 9, 10, 11],
            highlightIndex: 2,
            color: Color(0xFF5D4037),
          ),
        ],
      ),
    );
  }
}

class _WalkthroughStep extends StatelessWidget {
  const _WalkthroughStep({
    required this.step,
    required this.title,
    required this.description,
    required this.beforeDepths,
    required this.afterDepths,
    required this.highlightIndex,
    required this.color,
  });

  final int step;
  final String title;
  final String description;
  final List<int> beforeDepths;
  final List<int> afterDepths;
  final int highlightIndex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFFEFEBE9),
            const Color(0xFFD7CCC8).withValues(alpha: 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '$step',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF3E2723),
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: _DepthChainPanel(
                  label: 'BEFORE',
                  depths: beforeDepths,
                  highlightIndex: -1,
                  color: color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.arrow_forward, color: color),
              ),
              Expanded(
                child: _DepthChainPanel(
                  label: 'AFTER',
                  depths: afterDepths,
                  highlightIndex: highlightIndex,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DepthChainPanel extends StatelessWidget {
  const _DepthChainPanel({
    required this.label,
    required this.depths,
    required this.highlightIndex,
    required this.color,
  });

  final String label;
  final List<int> depths;
  final int highlightIndex;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          for (int i = 0; i < depths.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12.0 * i),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: i == highlightIndex
                          ? color
                          : color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'depth: ${depths[i]}',
                      style: TextStyle(
                        color: i == highlightIndex ? Colors.white : color,
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
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
}

// =============================================================================
// SECTION 9 — Pitfalls
// =============================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Pitfalls and Common Mistakes',
      subtitle: 'Failure modes when extending AbstractNode',
      accent: const Color(0xFFC62828),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _PitfallCard(
            severity: 'critical',
            title: 'Forgetting to call adoptChild()',
            wrong:
                'this._parent = child;',
            right:
                'adoptChild(child); // adoptChild sets parent and redepths.',
            explanation:
                'Manually assigning _parent skips the depth recomputation and '
                'the attach/detach propagation. The tree will appear connected '
                'but its invariants will be silently broken.',
          ),
          _PitfallCard(
            severity: 'critical',
            title: 'Mismatched detach() / attach()',
            wrong:
                'this.detach(); // child is still attached',
            right:
                'for (final c in children) c.detach();\nsuper.detach();',
            explanation:
                'Forgetting to detach children first leaves dangling owner '
                'references on the children. Listeners they registered with '
                'the owner will fire on a disposed owner.',
          ),
          _PitfallCard(
            severity: 'high',
            title: 'redepthChild ordering',
            wrong:
                'child._depth = this.depth + 1; // bypasses redepthChildren',
            right:
                'redepthChild(child); // bumps depth + recurses',
            explanation:
                'Directly setting depth on the child but not recursing means '
                'grandchildren keep their stale depth. Traversal algorithms '
                'that rely on ascending depth will produce wrong orderings.',
          ),
          _PitfallCard(
            severity: 'high',
            title: 'Calling attach() twice',
            wrong:
                'child.attach(owner); child.attach(otherOwner);',
            right:
                'if (!child.attached) child.attach(owner);',
            explanation:
                'attach() asserts that the node was previously detached. The '
                'assertion is your safety net — but in release mode the second '
                'call silently overwrites _owner, leaking listeners that the '
                'first owner registered.',
          ),
          _PitfallCard(
            severity: 'medium',
            title: 'Dropping a child without detaching first',
            wrong:
                'this._children.remove(child); child._parent = null;',
            right:
                'dropChild(child); // handles detach + parent clear.',
            explanation:
                'The internal _children list is not part of AbstractNode; '
                'each subclass owns it. But always funnel removals through '
                'dropChild so detach() fires deterministically.',
          ),
          _PitfallCard(
            severity: 'medium',
            title: 'Caching depth across reparenting',
            wrong:
                'final int cached = node.depth; // before reparent',
            right:
                'use node.depth fresh after every adoptChild()',
            explanation:
                'Subclasses sometimes pre-compute traversal orders. Any cache '
                'keyed by depth must be invalidated whenever an ancestor in '
                'the chain is re-parented.',
          ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.severity,
    required this.title,
    required this.wrong,
    required this.right,
    required this.explanation,
  });

  final String severity;
  final String title;
  final String wrong;
  final String right;
  final String explanation;

  Color get _severityColor {
    switch (severity) {
      case 'critical':
        return const Color(0xFFC62828);
      case 'high':
        return const Color(0xFFEF6C00);
      case 'medium':
        return const Color(0xFFF9A825);
      default:
        return const Color(0xFF6A1B9A);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color sev = _severityColor;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: sev.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: sev.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: sev,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  severity.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: sev,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _CodeBlock(
                  label: 'WRONG',
                  code: wrong,
                  color: const Color(0xFFC62828),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _CodeBlock(
                  label: 'RIGHT',
                  code: right,
                  color: const Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            explanation,
            style: const TextStyle(
              color: Color(0xFF455A64),
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({
    required this.label,
    required this.code,
    required this.color,
  });

  final String label;
  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 10,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — API Timeline / Notes
// =============================================================================
class _ApiTimelineSection extends StatelessWidget {
  const _ApiTimelineSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'API Notes and Historical Context',
      subtitle: 'Where AbstractNode sits in modern Flutter',
      accent: const Color(0xFF455A64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFFECEFF1),
                  const Color(0xFFCFD8DC).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFB0BEC5)),
            ),
            child: Column(
              children: const <Widget>[
                _TimelineEntry(
                  era: '2015',
                  title: 'Introduced for sky_engine',
                  body:
                      'AbstractNode was added so that RenderObject and Layer '
                      'could share a single parent/depth bookkeeping protocol.',
                ),
                _TimelineEntry(
                  era: '2017',
                  title: 'Adopted by SemanticsNode',
                  body:
                      'The semantics subsystem reused AbstractNode to keep '
                      'parent/child relationships consistent with the render '
                      'tree it mirrors.',
                ),
                _TimelineEntry(
                  era: '2020+',
                  title: 'Internal-only convention',
                  body:
                      'AbstractNode is rarely subclassed outside the framework. '
                      'When you see it in profiles, you are almost certainly '
                      'looking at a RenderObject, Layer, or SemanticsNode.',
                ),
                _TimelineEntry(
                  era: 'modern',
                  title: 'Still the contract',
                  body:
                      'Even with newer abstractions (Sliver protocol, '
                      'CompositedTransformLayer, etc.) every node ultimately '
                      'still wears AbstractNode\'s shape.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  const Color(0xFFE8F5E9),
                  const Color(0xFFC8E6C9).withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFA5D6A7)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Icon(Icons.lightbulb_outline,
                    color: Color(0xFF2E7D32), size: 22),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Take-away: most application developers never touch '
                    'AbstractNode directly. But understanding its shape — '
                    'parent, depth, owner, attached — is the fastest way to '
                    'read the source of any rendering or semantics subsystem '
                    'in Flutter.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF1B5E20),
                      height: 1.55,
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
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.era,
    required this.title,
    required this.body,
  });

  final String era;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF455A64),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              era,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF263238),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xFF455A64),
                    fontSize: 12.5,
                    height: 1.55,
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

// =============================================================================
// SECTION 11 — Footer
// =============================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            const Color(0xFF263238),
            const Color(0xFF37474F),
            const Color(0xFF455A64).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.account_tree_outlined,
                  color: Colors.white, size: 26),
              SizedBox(width: 10),
              Text(
                'AbstractNode — Reference Card',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 24,
            runSpacing: 12,
            children: const <Widget>[
              _FooterStat(label: 'Properties documented', value: '4'),
              _FooterStat(label: 'Methods documented', value: '6'),
              _FooterStat(label: 'Subclasses listed', value: '6'),
              _FooterStat(label: 'Walkthrough steps', value: '4'),
              _FooterStat(label: 'Pitfalls covered', value: '6'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 14),
          Text(
            'This deep demo is a fully-static visual reference. It performs no '
            'runtime calls against AbstractNode and is safe to render as a '
            'snapshot test or AST validation target.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 12.5,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterStat extends StatelessWidget {
  const _FooterStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
