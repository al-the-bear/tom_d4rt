// Deep visual demo for Flutter rendering hit-testing pipeline (HitTestResult,
// HitTestEntry, HitTestTarget, HitTestable). A static atlas covering the full
// pointer journey from GestureBinding through the render tree to the leaf
// RenderObject, with absorb/ignore comparisons, behavior matrices, layered
// hit-test ordering, and common pitfall callouts.
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// ignore_for_file: unused_element, unused_field, unused_element_parameter
import "package:flutter/material.dart";

// ---------------------------------------------------------------------------
// Palette and theme tokens. These are wide-ranging so each section can pull
// its own band of colors without re-deriving from the parent theme.
// ---------------------------------------------------------------------------

const Color _bgRoot = Color(0xFF0B1220);
const Color _bgPanel = Color(0xFF111B2D);
const Color _bgPanelAlt = Color(0xFF15233A);
const Color _bgCard = Color(0xFF1B2A44);
const Color _borderSoft = Color(0xFF243553);
const Color _borderStrong = Color(0xFF3A557F);

const Color _accentCyan = Color(0xFF22D3EE);
const Color _accentBlue = Color(0xFF60A5FA);
const Color _accentIndigo = Color(0xFF818CF8);
const Color _accentViolet = Color(0xFFA78BFA);
const Color _accentPink = Color(0xFFF472B6);
const Color _accentRose = Color(0xFFFB7185);
const Color _accentAmber = Color(0xFFFBBF24);
const Color _accentLime = Color(0xFFA3E635);
const Color _accentEmerald = Color(0xFF34D399);
const Color _accentTeal = Color(0xFF2DD4BF);

const Color _textPrimary = Color(0xFFE5ECFA);
const Color _textSecondary = Color(0xFFB7C2D8);
const Color _textMuted = Color(0xFF7E8AA6);
const Color _textDim = Color(0xFF5E6A86);

const Color _okGreen = Color(0xFF22C55E);
const Color _warnAmber = Color(0xFFF59E0B);
const Color _errRed = Color(0xFFEF4444);
const Color _infoBlue = Color(0xFF3B82F6);

// ---------------------------------------------------------------------------
// Data classes used across the atlas. Pure-value descriptors only; no logic.
// ---------------------------------------------------------------------------

class _PipelineStage {
  const _PipelineStage({
    required this.index,
    required this.shortName,
    required this.title,
    required this.role,
    required this.detail,
    required this.tint,
  });

  final int index;
  final String shortName;
  final String title;
  final String role;
  final String detail;
  final Color tint;
}

class _BehaviorRow {
  const _BehaviorRow({
    required this.behavior,
    required this.opaqueArea,
    required this.transparentArea,
    required this.childArea,
    required this.passThrough,
    required this.note,
  });

  final String behavior;
  final String opaqueArea;
  final String transparentArea;
  final String childArea;
  final String passThrough;
  final String note;
}

class _LayerCase {
  const _LayerCase({
    required this.id,
    required this.title,
    required this.summary,
    required this.layers,
    required this.expected,
  });

  final String id;
  final String title;
  final String summary;
  final List<_LayerStack> layers;
  final String expected;
}

class _LayerStack {
  const _LayerStack({
    required this.label,
    required this.kind,
    required this.color,
    required this.captures,
  });

  final String label;
  final String kind;
  final Color color;
  final bool captures;
}

class _TraceStep {
  const _TraceStep({
    required this.index,
    required this.actor,
    required this.action,
    required this.payload,
    required this.tint,
  });

  final int index;
  final String actor;
  final String action;
  final String payload;
  final Color tint;
}

class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.symptom,
    required this.cause,
    required this.fix,
    required this.tint,
  });

  final String title;
  final String symptom;
  final String cause;
  final String fix;
  final Color tint;
}

class _ApiEntry {
  const _ApiEntry({
    required this.symbol,
    required this.kind,
    required this.signature,
    required this.purpose,
  });

  final String symbol;
  final String kind;
  final String signature;
  final String purpose;
}

class _ComparisonRow {
  const _ComparisonRow({
    required this.attribute,
    required this.absorb,
    required this.ignore,
    required this.note,
  });

  final String attribute;
  final String absorb;
  final String ignore;
  final String note;
}

// ---------------------------------------------------------------------------
// Reference data for each section. Hand-authored, intentionally verbose.
// ---------------------------------------------------------------------------

const List<_PipelineStage> _pipelineStages = <_PipelineStage>[
  _PipelineStage(
    index: 0,
    shortName: "Pointer",
    title: "Pointer event source",
    role: "PointerDataPacket from engine",
    detail:
        "The platform engine emits a PointerDataPacket which is decoded into "
        "PointerEvent objects (down/move/up/cancel/hover/signal) before any "
        "framework code sees it.",
    tint: _accentCyan,
  ),
  _PipelineStage(
    index: 1,
    shortName: "GestureBinding",
    title: "GestureBinding._handlePointerEvent",
    role: "Routes raw pointer events",
    detail:
        "GestureBinding receives the decoded event and calls hitTest on the "
        "current RendererBinding to find a chain of HitTestEntry items for "
        "the pointer location.",
    tint: _accentBlue,
  ),
  _PipelineStage(
    index: 2,
    shortName: "RendererBinding",
    title: "RendererBinding.hitTest",
    role: "Bridges gesture to render world",
    detail:
        "RendererBinding asks RenderView to perform a hit-test starting at "
        "the root, accumulating entries into the supplied HitTestResult.",
    tint: _accentIndigo,
  ),
  _PipelineStage(
    index: 3,
    shortName: "RenderView",
    title: "RenderView.hitTest",
    role: "Root of the render tree",
    detail:
        "RenderView is the root HitTestable. It walks down into its child "
        "RenderObject (typically the wrapped widget tree under WidgetsApp).",
    tint: _accentViolet,
  ),
  _PipelineStage(
    index: 4,
    shortName: "RenderObject",
    title: "RenderObject.hitTest / hitTestChildren",
    role: "Per-node hit test",
    detail:
        "Each RenderObject decides whether the hit position lies within its "
        "bounds, then asks each child via hitTestChildren in reverse paint "
        "order. Each accepting node adds a BoxHitTestEntry.",
    tint: _accentPink,
  ),
  _PipelineStage(
    index: 5,
    shortName: "HitTestResult",
    title: "HitTestResult accumulator",
    role: "Front-to-back list",
    detail:
        "HitTestResult collects HitTestEntry objects. The order matters: the "
        "first entry is the topmost hit target. Gesture arenas iterate this "
        "list when dispatching events.",
    tint: _accentRose,
  ),
  _PipelineStage(
    index: 6,
    shortName: "Dispatch",
    title: "handleEvent + dispatch",
    role: "Entries receive event",
    detail:
        "GestureBinding.dispatchEvent iterates the HitTestResult and invokes "
        "HitTestTarget.handleEvent on each entry's target. Gesture recognizers "
        "compete inside the GestureArenaManager.",
    tint: _accentAmber,
  ),
];

const List<_BehaviorRow> _behaviorMatrix = <_BehaviorRow>[
  _BehaviorRow(
    behavior: "opaque",
    opaqueArea: "captures",
    transparentArea: "captures",
    childArea: "captures",
    passThrough: "blocked",
    note:
        "Treats the entire region as opaque to hit tests, regardless of "
        "actual painted pixels. Best for tap surfaces over blank areas.",
  ),
  _BehaviorRow(
    behavior: "translucent",
    opaqueArea: "captures",
    transparentArea: "captures",
    childArea: "captures",
    passThrough: "allowed",
    note:
        "Captures hits across the whole region AND adds itself to the chain "
        "while still allowing siblings below to be tested.",
  ),
  _BehaviorRow(
    behavior: "deferToChild",
    opaqueArea: "depends on child",
    transparentArea: "ignored",
    childArea: "captures via child",
    passThrough: "allowed",
    note:
        "Only participates if a child accepts the hit. Empty transparent "
        "regions effectively pass through to whatever is behind.",
  ),
];

const List<_LayerCase> _layerCases = <_LayerCase>[
  _LayerCase(
    id: "stack-overlap",
    title: "Stacked listeners overlapping",
    summary:
        "Two Listeners share a region. Topmost capture wins front-to-back; "
        "translucent allows secondary capture.",
    layers: <_LayerStack>[
      _LayerStack(
        label: "Listener A (opaque, on top)",
        kind: "listener",
        color: _accentEmerald,
        captures: true,
      ),
      _LayerStack(
        label: "Listener B (deferToChild, behind)",
        kind: "listener",
        color: _accentTeal,
        captures: false,
      ),
      _LayerStack(
        label: "Background container",
        kind: "container",
        color: _accentIndigo,
        captures: false,
      ),
    ],
    expected:
        "Only Listener A receives the pointer event because it is opaque and "
        "front-most in paint order.",
  ),
  _LayerCase(
    id: "translucent-chain",
    title: "Translucent capture chain",
    summary:
        "Translucent listener stacks both itself AND descendants into the "
        "hit-test result. Useful for analytics overlays.",
    layers: <_LayerStack>[
      _LayerStack(
        label: "Overlay (translucent)",
        kind: "listener",
        color: _accentAmber,
        captures: true,
      ),
      _LayerStack(
        label: "Button (opaque)",
        kind: "button",
        color: _accentPink,
        captures: true,
      ),
      _LayerStack(
        label: "Card background",
        kind: "container",
        color: _accentBlue,
        captures: false,
      ),
    ],
    expected:
        "Both Overlay and Button receive the event; the overlay can observe "
        "the press without blocking the underlying control.",
  ),
  _LayerCase(
    id: "ignore-pointer",
    title: "IgnorePointer cuts subtree",
    summary:
        "IgnorePointer drops itself and all descendants from hit testing "
        "without changing layout or paint.",
    layers: <_LayerStack>[
      _LayerStack(
        label: "IgnorePointer (root)",
        kind: "barrier",
        color: _accentRose,
        captures: false,
      ),
      _LayerStack(
        label: "Inner button (would-be opaque)",
        kind: "button",
        color: _textMuted,
        captures: false,
      ),
      _LayerStack(
        label: "Page scaffold below",
        kind: "container",
        color: _accentIndigo,
        captures: true,
      ),
    ],
    expected:
        "The button does NOT receive events; the page scaffold below the "
        "IgnorePointer captures the pointer instead.",
  ),
  _LayerCase(
    id: "absorb-pointer",
    title: "AbsorbPointer swallows hits",
    summary:
        "AbsorbPointer captures hits itself but prevents descendants AND "
        "siblings below from receiving them.",
    layers: <_LayerStack>[
      _LayerStack(
        label: "AbsorbPointer (root)",
        kind: "barrier",
        color: _accentViolet,
        captures: true,
      ),
      _LayerStack(
        label: "Inner button",
        kind: "button",
        color: _textMuted,
        captures: false,
      ),
      _LayerStack(
        label: "Page below",
        kind: "container",
        color: _textMuted,
        captures: false,
      ),
    ],
    expected:
        "Only AbsorbPointer itself appears in the HitTestResult. Inner "
        "content and underlying widgets are inert.",
  ),
  _LayerCase(
    id: "positioned-offscreen",
    title: "Positioned offscreen child",
    summary:
        "Stack with Positioned drawing outside parent bounds. Hit tests are "
        "clipped to the Stack, regardless of where the child is painted.",
    layers: <_LayerStack>[
      _LayerStack(
        label: "Stack (no overflow clip via hit test)",
        kind: "container",
        color: _accentBlue,
        captures: false,
      ),
      _LayerStack(
        label: "Positioned tile (drawn outside)",
        kind: "tile",
        color: _accentLime,
        captures: false,
      ),
    ],
    expected:
        "The Positioned tile rendered outside the Stack is visible but does "
        "NOT receive pointer events from outside the Stack's bounds.",
  ),
];

const List<_TraceStep> _traceSteps = <_TraceStep>[
  _TraceStep(
    index: 0,
    actor: "Engine",
    action: "PointerDataPacket",
    payload: "device=0 kind=touch x=120 y=340 phase=down",
    tint: _accentCyan,
  ),
  _TraceStep(
    index: 1,
    actor: "GestureBinding",
    action: "_handlePointerEvent",
    payload: "PointerDownEvent#42 -> RendererBinding.hitTest(result)",
    tint: _accentBlue,
  ),
  _TraceStep(
    index: 2,
    actor: "RendererBinding",
    action: "hitTest(result, position)",
    payload: "Delegates to RenderView at (120, 340)",
    tint: _accentIndigo,
  ),
  _TraceStep(
    index: 3,
    actor: "RenderView",
    action: "hitTest",
    payload: "result.add(HitTestEntry(RenderView)); call child",
    tint: _accentViolet,
  ),
  _TraceStep(
    index: 4,
    actor: "RenderRepaintBoundary",
    action: "hitTest",
    payload: "Forward to child (no capture; bounds OK)",
    tint: _accentPink,
  ),
  _TraceStep(
    index: 5,
    actor: "RenderSemanticsAnnotations",
    action: "hitTest",
    payload: "Forward; adds entry only if semantics relevant",
    tint: _accentRose,
  ),
  _TraceStep(
    index: 6,
    actor: "RenderStack",
    action: "hitTestChildren",
    payload: "Iterates children reverse paint order",
    tint: _accentAmber,
  ),
  _TraceStep(
    index: 7,
    actor: "RenderConstrainedBox",
    action: "hitTest",
    payload: "In bounds; forward to child",
    tint: _accentLime,
  ),
  _TraceStep(
    index: 8,
    actor: "RenderPointerListener",
    action: "hitTest + add entry",
    payload: "Listener captures (opaque); pushes BoxHitTestEntry",
    tint: _accentEmerald,
  ),
  _TraceStep(
    index: 9,
    actor: "HitTestResult",
    action: "snapshot",
    payload: "[Listener, ConstrainedBox, Stack, ..., RenderView]",
    tint: _accentTeal,
  ),
  _TraceStep(
    index: 10,
    actor: "GestureBinding",
    action: "dispatchEvent",
    payload: "for entry in result -> entry.target.handleEvent",
    tint: _accentBlue,
  ),
  _TraceStep(
    index: 11,
    actor: "Recognizer",
    action: "GestureArenaManager.sweep",
    payload: "TapGestureRecognizer resolves -> onTap()",
    tint: _accentAmber,
  ),
];

const List<_Pitfall> _pitfalls = <_Pitfall>[
  _Pitfall(
    title: "Stack child overlap eats taps",
    symptom:
        "Bottom button feels dead even though it looks visible under the "
        "transparent overlay.",
    cause:
        "An overlay widget that paints translucent pixels still hit-tests as "
        "opaque when wrapped in a default-behaved GestureDetector.",
    fix:
        "Either use IgnorePointer on the overlay or pass "
        "HitTestBehavior.translucent / deferToChild so events reach below.",
    tint: _accentRose,
  ),
  _Pitfall(
    title: "Positioned content outside parent",
    symptom:
        "Visible tile rendered with negative offsets cannot be tapped.",
    cause:
        "Hit testing of Positioned children is clipped to the Stack's bounds "
        "even if paint is not. Pointer outside the Stack never reaches it.",
    fix:
        "Increase the Stack's bounds, use Overlay/OverlayEntry, or restructure "
        "so the interactive element lives inside its parent's hit region.",
    tint: _accentAmber,
  ),
  _Pitfall(
    title: "Listener vs GestureDetector confusion",
    symptom:
        "Calling onTap fires inconsistently when nested inside a Listener "
        "subtree.",
    cause:
        "Listener delivers raw pointer events synchronously; GestureDetector "
        "competes inside the gesture arena and may lose if a parent claims.",
    fix:
        "Pick the right tool: Listener for raw streams (canvases, custom "
        "input); GestureDetector for semantic gestures. Avoid mixing on "
        "the same node without HitTestBehavior tuning.",
    tint: _accentPink,
  ),
  _Pitfall(
    title: "AbsorbPointer used where IgnorePointer was meant",
    symptom:
        "Background still receives presses even though a barrier overlay is "
        "present.",
    cause:
        "AbsorbPointer captures itself but does not delegate to siblings "
        "below; IgnorePointer just removes its subtree from hit testing.",
    fix:
        "Use AbsorbPointer when you DO want the barrier to swallow input; "
        "use IgnorePointer when you want the subtree to be invisible to hit "
        "tests but allow widgets below to still receive events.",
    tint: _accentViolet,
  ),
  _Pitfall(
    title: "Transparent Container is not hit-testable",
    symptom:
        "Large transparent Container wrapping content fails to receive taps.",
    cause:
        "A Container without color/decoration paints nothing; GestureDetector "
        "with default deferToChild ignores empty regions.",
    fix:
        "Provide a non-null color (even Colors.transparent with translucent "
        "behavior) or set behavior: HitTestBehavior.opaque/translucent.",
    tint: _accentEmerald,
  ),
  _Pitfall(
    title: "Misordered Stack layers",
    symptom:
        "The intended top-most control is reachable only through gaps in "
        "the foreground layer.",
    cause:
        "Stack children are painted (and hit-tested in reverse) in declared "
        "order. Children later in the list are higher in z.",
    fix:
        "Reorder so interactive elements come AFTER decorative overlays, or "
        "use IgnorePointer to disable hit-testing on overlays.",
    tint: _accentTeal,
  ),
];

const List<_ApiEntry> _apiSurface = <_ApiEntry>[
  _ApiEntry(
    symbol: "HitTestResult",
    kind: "class",
    signature: "class HitTestResult",
    purpose:
        "Accumulates HitTestEntry objects produced while walking the render "
        "tree. Iterated front-to-back during event dispatch.",
  ),
  _ApiEntry(
    symbol: "HitTestResult.add",
    kind: "method",
    signature: "void add(HitTestEntry entry)",
    purpose:
        "Appends an entry. Called by RenderObject.hitTest implementations "
        "when a node accepts the hit.",
  ),
  _ApiEntry(
    symbol: "HitTestResult.path",
    kind: "getter",
    signature: "Iterable<HitTestEntry> get path",
    purpose:
        "Returns the accumulated entries in dispatch order (topmost first).",
  ),
  _ApiEntry(
    symbol: "HitTestEntry",
    kind: "class",
    signature: "class HitTestEntry<T extends HitTestTarget>",
    purpose:
        "A single (target, transform) pair recorded during hit testing. "
        "Typed by the target.",
  ),
  _ApiEntry(
    symbol: "HitTestEntry.target",
    kind: "field",
    signature: "T get target",
    purpose:
        "The HitTestTarget that accepted the hit. Receives handleEvent later.",
  ),
  _ApiEntry(
    symbol: "BoxHitTestEntry",
    kind: "class",
    signature: "class BoxHitTestEntry extends HitTestEntry<RenderBox>",
    purpose:
        "Specialization of HitTestEntry carrying the local position within "
        "the RenderBox that was hit.",
  ),
  _ApiEntry(
    symbol: "HitTestTarget",
    kind: "interface",
    signature: "abstract class HitTestTarget { void handleEvent(...); }",
    purpose:
        "Anything that can receive a dispatched PointerEvent. Implemented by "
        "RenderObject, GestureBinding, and friends.",
  ),
  _ApiEntry(
    symbol: "HitTestable",
    kind: "interface",
    signature: "abstract class HitTestable { void hitTest(...); }",
    purpose:
        "Anything that can be asked to perform hit testing. Implemented by "
        "RendererBinding and RenderView at the top of the tree.",
  ),
  _ApiEntry(
    symbol: "RenderBox.hitTest",
    kind: "method",
    signature: "bool hitTest(BoxHitTestResult result, {required Offset position})",
    purpose:
        "Bounds-check + delegate to hitTestSelf and hitTestChildren; appends "
        "a BoxHitTestEntry on accept.",
  ),
  _ApiEntry(
    symbol: "RenderBox.hitTestSelf",
    kind: "method",
    signature: "bool hitTestSelf(Offset position)",
    purpose:
        "Override to claim the hit for the node itself (after children have "
        "had a chance).",
  ),
  _ApiEntry(
    symbol: "RenderBox.hitTestChildren",
    kind: "method",
    signature: "bool hitTestChildren(BoxHitTestResult result, ...)",
    purpose:
        "Override to forward the hit test to relevant children in reverse "
        "paint order.",
  ),
  _ApiEntry(
    symbol: "HitTestBehavior.opaque",
    kind: "enum",
    signature: "HitTestBehavior.opaque",
    purpose:
        "Treat the whole node as opaque to hit tests; blocks siblings below.",
  ),
  _ApiEntry(
    symbol: "HitTestBehavior.translucent",
    kind: "enum",
    signature: "HitTestBehavior.translucent",
    purpose:
        "Capture hits AND allow siblings below to also be tested.",
  ),
  _ApiEntry(
    symbol: "HitTestBehavior.deferToChild",
    kind: "enum",
    signature: "HitTestBehavior.deferToChild",
    purpose:
        "Only participate when a descendant accepts the hit.",
  ),
];

const List<_ComparisonRow> _absorbVsIgnore = <_ComparisonRow>[
  _ComparisonRow(
    attribute: "Self captures pointer",
    absorb: "yes (acts as barrier)",
    ignore: "no (invisible to hit test)",
    note:
        "AbsorbPointer is the right choice for modal barriers; IgnorePointer "
        "is the right choice for read-only overlays.",
  ),
  _ComparisonRow(
    attribute: "Descendants captured",
    absorb: "no",
    ignore: "no",
    note:
        "Both remove their subtree from hit testing.",
  ),
  _ComparisonRow(
    attribute: "Siblings below captured",
    absorb: "no",
    ignore: "yes",
    note:
        "The biggest practical difference: IgnorePointer lets events through "
        "to widgets stacked below.",
  ),
  _ComparisonRow(
    attribute: "Affects layout",
    absorb: "no",
    ignore: "no",
    note:
        "Both are pure hit-test modifiers and do not change layout or paint.",
  ),
  _ComparisonRow(
    attribute: "Affects semantics",
    absorb: "optional (ignoringSemantics)",
    ignore: "optional (ignoringSemantics)",
    note:
        "Both expose a parameter controlling whether semantics are also "
        "removed for accessibility.",
  ),
];

const List<String> _glossary = <String>[
  "Pointer: a hardware or simulated input source (touch, mouse, stylus).",
  "PointerEvent: a typed event (down, move, up, hover, signal, cancel).",
  "HitTestable: anything that can be asked to hit-test (RendererBinding, RenderView).",
  "HitTestTarget: anything that can receive a dispatched event.",
  "HitTestEntry: one accepted target in the result, possibly with local position.",
  "HitTestResult: the ordered accumulator iterated during dispatch.",
  "BoxHitTestEntry: specialization for RenderBox with local hit position.",
  "BoxHitTestResult: specialization of HitTestResult for the box protocol.",
  "GestureBinding: framework binding that routes events into the render world.",
  "RendererBinding: glues GestureBinding with the render tree via RenderView.",
  "RenderObject: leaf or node implementing hit-test methods.",
  "GestureArena: per-pointer arena that resolves competing recognizers.",
  "Recognizer: an object that joins arenas and claims gestures.",
  "Listener: widget exposing raw pointer streams (RenderPointerListener).",
  "GestureDetector: widget composing recognizers behind a semantic facade.",
  "AbsorbPointer: barrier that captures hits and blocks siblings below.",
  "IgnorePointer: makes its subtree invisible to hit testing.",
];

// ---------------------------------------------------------------------------
// Tiny shared primitives. Pure widgets, no logic, used by every section.
// ---------------------------------------------------------------------------

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
    this.compact = false,
  });

  final String tag;
  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _bgPanel,
            _bgPanelAlt,
            accent.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderSoft),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20, 18, 20, compact ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accent.withValues(alpha: 0.45)),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.6),
                  accent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.text,
    required this.color,
    this.icon,
  });

  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 12, color: color),
            SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text, this.color = _accentBlue});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 6, right: 10),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Arrow extends StatelessWidget {
  const _Arrow({required this.color, this.vertical = false});

  final Color color;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 2,
            height: 22,
            color: color.withValues(alpha: 0.8),
          ),
          Icon(Icons.keyboard_arrow_down_rounded, color: color, size: 22),
        ],
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 28,
          height: 2,
          color: color.withValues(alpha: 0.8),
        ),
        Icon(Icons.chevron_right_rounded, color: color, size: 22),
      ],
    );
  }
}

class _StageBadge extends StatelessWidget {
  const _StageBadge({required this.stage});

  final _PipelineStage stage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            stage.tint.withValues(alpha: 0.22),
            stage.tint.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: stage.tint.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: stage.tint.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                  border: Border.all(color: stage.tint),
                ),
                child: Text(
                  "${stage.index}",
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  stage.shortName,
                  style: TextStyle(
                    color: stage.tint,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            stage.title,
            style: TextStyle(
              color: _textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            stage.role,
            style: TextStyle(
              color: _textMuted,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _IntroSection -- the title card with theme metadata and quick stats.
// ---------------------------------------------------------------------------

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 18, 18, 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _accentCyan.withValues(alpha: 0.22),
            _accentIndigo.withValues(alpha: 0.18),
            _accentViolet.withValues(alpha: 0.14),
            _bgPanel,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _borderStrong),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      _accentCyan.withValues(alpha: 0.7),
                      _accentIndigo.withValues(alpha: 0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.touch_app_rounded, color: Colors.white, size: 32),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hit-Test Pipeline Atlas",
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "A static walkthrough of HitTestResult, HitTestEntry, "
                      "HitTestTarget, and HitTestable across the journey "
                      "from PointerEvent to RenderObject.",
                      style: TextStyle(
                        color: _textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _Pill(text: "HitTestable", color: _accentCyan, icon: Icons.hub_outlined),
              _Pill(text: "HitTestTarget", color: _accentBlue, icon: Icons.adjust_rounded),
              _Pill(text: "HitTestEntry", color: _accentIndigo, icon: Icons.label_outline),
              _Pill(text: "HitTestResult", color: _accentViolet, icon: Icons.format_list_bulleted_rounded),
              _Pill(text: "GestureBinding", color: _accentPink, icon: Icons.pan_tool_alt_outlined),
              _Pill(text: "RenderObject", color: _accentRose, icon: Icons.account_tree_outlined),
              _Pill(text: "RenderView", color: _accentAmber, icon: Icons.layers_outlined),
              _Pill(text: "BoxHitTestEntry", color: _accentLime, icon: Icons.crop_square_rounded),
              _Pill(text: "Listener", color: _accentEmerald, icon: Icons.sensors_rounded),
              _Pill(text: "IgnorePointer", color: _accentTeal, icon: Icons.block_rounded),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: <Widget>[
              _StatTile(
                label: "Pipeline stages",
                value: "${_pipelineStages.length}",
                color: _accentCyan,
              ),
              SizedBox(width: 10),
              _StatTile(
                label: "Behaviors",
                value: "${_behaviorMatrix.length}",
                color: _accentIndigo,
              ),
              SizedBox(width: 10),
              _StatTile(
                label: "Trace steps",
                value: "${_traceSteps.length}",
                color: _accentAmber,
              ),
              SizedBox(width: 10),
              _StatTile(
                label: "Pitfalls",
                value: "${_pitfalls.length}",
                color: _accentRose,
              ),
              SizedBox(width: 10),
              _StatTile(
                label: "API entries",
                value: "${_apiSurface.length}",
                color: _accentEmerald,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(
                color: _textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _PipelineOverviewSection -- horizontal cascade of pipeline stages.
// ---------------------------------------------------------------------------

class _PipelineOverviewSection extends StatelessWidget {
  const _PipelineOverviewSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 01",
      title: "Pipeline Overview",
      subtitle:
          "Pointer enters from the engine, becomes a PointerEvent inside "
          "GestureBinding, runs down the render tree through HitTestable "
          "interfaces, and accumulates into a HitTestResult.",
      accent: _accentCyan,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildStageRow(),
            ),
          ),
          SizedBox(height: 22),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: <Widget>[
              for (final _PipelineStage s in _pipelineStages)
                _StageDetailCard(stage: s),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStageRow() {
    final List<Widget> out = <Widget>[];
    for (int i = 0; i < _pipelineStages.length; i++) {
      out.add(_StageBadge(stage: _pipelineStages[i]));
      if (i != _pipelineStages.length - 1) {
        out.add(SizedBox(width: 6));
        out.add(_Arrow(color: _pipelineStages[i].tint));
        out.add(SizedBox(width: 6));
      }
    }
    return out;
  }
}

class _StageDetailCard extends StatelessWidget {
  const _StageDetailCard({required this.stage});

  final _PipelineStage stage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            stage.tint.withValues(alpha: 0.18),
            _bgCard,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: stage.tint.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _Pill(text: "STAGE ${stage.index}", color: stage.tint),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  stage.title,
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            stage.role,
            style: TextStyle(
              color: stage.tint,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8),
          Text(
            stage.detail,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _BehaviorMatrixSection -- HitTestBehavior matrix table.
// ---------------------------------------------------------------------------

class _BehaviorMatrixSection extends StatelessWidget {
  const _BehaviorMatrixSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 02",
      title: "HitTestBehavior Matrix",
      subtitle:
          "How HitTestBehavior.opaque / translucent / deferToChild affect "
          "capture of opaque, transparent, child, and pass-through regions.",
      accent: _accentIndigo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: _bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderSoft),
            ),
            child: Column(
              children: <Widget>[
                _matrixHeaderRow(),
                for (final _BehaviorRow row in _behaviorMatrix)
                  _matrixDataRow(row),
              ],
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: <Widget>[
              Expanded(child: _MockOutcomeCard(
                title: "Opaque button",
                behavior: "opaque",
                outcome: "Tap captured by THIS node. "
                    "Background and siblings below get nothing.",
                color: _accentEmerald,
              )),
              SizedBox(width: 10),
              Expanded(child: _MockOutcomeCard(
                title: "Translucent overlay",
                behavior: "translucent",
                outcome: "Overlay captures, AND the button below also "
                    "appears in the HitTestResult.",
                color: _accentAmber,
              )),
              SizedBox(width: 10),
              Expanded(child: _MockOutcomeCard(
                title: "DeferToChild wrapper",
                behavior: "deferToChild",
                outcome: "Wrapper participates only where a child "
                    "actually accepts the hit.",
                color: _accentRose,
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _matrixHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _accentIndigo.withValues(alpha: 0.22),
            _accentViolet.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: const <Widget>[
          _MxCell(text: "Behavior", flex: 2, header: true),
          _MxCell(text: "Opaque area", flex: 2, header: true),
          _MxCell(text: "Transparent area", flex: 2, header: true),
          _MxCell(text: "Child area", flex: 2, header: true),
          _MxCell(text: "Pass-through", flex: 2, header: true),
          _MxCell(text: "Note", flex: 4, header: true),
        ],
      ),
    );
  }

  Widget _matrixDataRow(_BehaviorRow row) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: _borderSoft)),
      ),
      child: Row(
        children: <Widget>[
          _MxCell(text: row.behavior, flex: 2, accent: _accentIndigo, bold: true),
          _MxCell(text: row.opaqueArea, flex: 2),
          _MxCell(text: row.transparentArea, flex: 2),
          _MxCell(text: row.childArea, flex: 2),
          _MxCell(text: row.passThrough, flex: 2),
          _MxCell(text: row.note, flex: 4, muted: true),
        ],
      ),
    );
  }
}

class _MxCell extends StatelessWidget {
  const _MxCell({
    required this.text,
    required this.flex,
    this.header = false,
    this.bold = false,
    this.muted = false,
    this.accent,
  });

  final String text;
  final int flex;
  final bool header;
  final bool bold;
  final bool muted;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final Color color = header
        ? _textPrimary
        : (accent ?? (muted ? _textMuted : _textSecondary));
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: header ? 12 : 12,
            fontWeight: header || bold ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: header ? 0.4 : 0,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _MockOutcomeCard extends StatelessWidget {
  const _MockOutcomeCard({
    required this.title,
    required this.behavior,
    required this.outcome,
    required this.color,
  });

  final String title;
  final String behavior;
  final String outcome;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.22),
            _bgCard,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Pill(text: behavior, color: color),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: _textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            outcome,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _LayeredExampleSection -- visualizes stacked listeners and barrier cases.
// ---------------------------------------------------------------------------

class _LayeredExampleSection extends StatelessWidget {
  const _LayeredExampleSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 03",
      title: "Layered Hit-Test Order",
      subtitle:
          "Front-to-back, the topmost capturer wins. AbsorbPointer / "
          "IgnorePointer / overlapping Stack children each produce a "
          "distinct pattern.",
      accent: _accentViolet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _LayerCase c in _layerCases) ...<Widget>[
            _LayerCaseCard(layerCase: c),
            SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _LayerCaseCard extends StatelessWidget {
  const _LayerCaseCard({required this.layerCase});

  final _LayerCase layerCase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _bgCard,
            _accentViolet.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderSoft),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _Pill(text: layerCase.id.toUpperCase(), color: _accentViolet),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        layerCase.title,
                        style: TextStyle(
                          color: _textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  layerCase.summary,
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _accentEmerald.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _accentEmerald.withValues(alpha: 0.35)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.check_circle_outline, color: _accentEmerald, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          layerCase.expected,
                          style: TextStyle(
                            color: _accentEmerald,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: _LayerVisual(layers: layerCase.layers),
          ),
        ],
      ),
    );
  }
}

class _LayerVisual extends StatelessWidget {
  const _LayerVisual({required this.layers});

  final List<_LayerStack> layers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _bgPanel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < layers.length; i++) ...<Widget>[
            _LayerRow(layer: layers[i], depth: i),
            if (i != layers.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _Arrow(color: _textDim, vertical: true),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _LayerRow extends StatelessWidget {
  const _LayerRow({required this.layer, required this.depth});

  final _LayerStack layer;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            layer.color.withValues(alpha: 0.25),
            layer.color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: layer.color.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: layer.color.withValues(alpha: 0.3),
              shape: BoxShape.circle,
              border: Border.all(color: layer.color),
            ),
            child: Text(
              "$depth",
              style: TextStyle(
                color: _textPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              layer.label,
              style: TextStyle(
                color: _textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 8),
          _Pill(
            text: layer.captures ? "captures" : "skipped",
            color: layer.captures ? _accentEmerald : _textDim,
            icon: layer.captures
                ? Icons.check_rounded
                : Icons.remove_circle_outline,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _AbsorbIgnoreSection -- side-by-side comparison.
// ---------------------------------------------------------------------------

class _AbsorbIgnoreSection extends StatelessWidget {
  const _AbsorbIgnoreSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 04",
      title: "AbsorbPointer vs IgnorePointer",
      subtitle:
          "Both remove descendants from hit-testing but differ on whether "
          "the wrapper itself captures and whether widgets below the "
          "wrapper are still reachable.",
      accent: _accentPink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _BarrierPanel(
                title: "AbsorbPointer",
                description:
                    "Acts like a brick wall. The wrapper itself is in the "
                    "hit-test result; descendants and underlying widgets "
                    "below are NOT reached.",
                accent: _accentRose,
                icon: Icons.shield_rounded,
                captureSelf: true,
                captureBelow: false,
              )),
              SizedBox(width: 12),
              Expanded(child: _BarrierPanel(
                title: "IgnorePointer",
                description:
                    "Acts like glass. Descendants are invisible to hit "
                    "testing but widgets BELOW the wrapper can still "
                    "receive events.",
                accent: _accentBlue,
                icon: Icons.visibility_off_rounded,
                captureSelf: false,
                captureBelow: true,
              )),
            ],
          ),
          SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _borderSoft),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        _accentPink.withValues(alpha: 0.22),
                        _accentRose.withValues(alpha: 0.10),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: const <Widget>[
                      _MxCell(text: "Attribute", flex: 4, header: true),
                      _MxCell(text: "AbsorbPointer", flex: 3, header: true),
                      _MxCell(text: "IgnorePointer", flex: 3, header: true),
                      _MxCell(text: "Note", flex: 6, header: true),
                    ],
                  ),
                ),
                for (final _ComparisonRow row in _absorbVsIgnore)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: _borderSoft)),
                    ),
                    child: Row(
                      children: <Widget>[
                        _MxCell(text: row.attribute, flex: 4, bold: true),
                        _MxCell(text: row.absorb, flex: 3, accent: _accentRose),
                        _MxCell(text: row.ignore, flex: 3, accent: _accentBlue),
                        _MxCell(text: row.note, flex: 6, muted: true),
                      ],
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

class _BarrierPanel extends StatelessWidget {
  const _BarrierPanel({
    required this.title,
    required this.description,
    required this.accent,
    required this.icon,
    required this.captureSelf,
    required this.captureBelow,
  });

  final String title;
  final String description;
  final Color accent;
  final IconData icon;
  final bool captureSelf;
  final bool captureBelow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            accent.withValues(alpha: 0.22),
            _bgCard,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 22),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
              height: 1.45,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              _Pill(
                text: captureSelf ? "self captures" : "self transparent",
                color: captureSelf ? _accentEmerald : _textDim,
                icon: captureSelf
                    ? Icons.check_rounded
                    : Icons.remove_rounded,
              ),
              SizedBox(width: 6),
              _Pill(
                text: captureBelow ? "below reachable" : "below blocked",
                color: captureBelow ? _accentEmerald : _errRed,
                icon: captureBelow
                    ? Icons.arrow_downward_rounded
                    : Icons.block_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _JourneyTraceSection -- a step-by-step trace of a pointer down event.
// ---------------------------------------------------------------------------

class _JourneyTraceSection extends StatelessWidget {
  const _JourneyTraceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 05",
      title: "Pointer Journey Trace",
      subtitle:
          "A linear trace of a single PointerDownEvent travelling from the "
          "engine through GestureBinding to a final TapGestureRecognizer.",
      accent: _accentAmber,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderSoft),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (final _TraceStep step in _traceSteps) _TraceRow(step: step),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _accentLime.withValues(alpha: 0.18),
                    _accentEmerald.withValues(alpha: 0.10),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _accentEmerald.withValues(alpha: 0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.flag_rounded, color: _accentEmerald, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "End-to-end: the topmost HitTestEntry receives "
                      "handleEvent first; recognizers compete in their "
                      "GestureArena; onTap fires after sweep.",
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
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
}

class _TraceRow extends StatelessWidget {
  const _TraceRow({required this.step});

  final _TraceStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            step.tint.withValues(alpha: 0.20),
            step.tint.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.tint.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: step.tint.withValues(alpha: 0.30),
              shape: BoxShape.circle,
              border: Border.all(color: step.tint),
            ),
            child: Text(
              "${step.index}",
              style: TextStyle(
                color: _textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  step.actor,
                  style: TextStyle(
                    color: step.tint,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  step.action,
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 5,
            child: Text(
              step.payload,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 12,
                fontFamily: "monospace",
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _PitfallsSection -- common mistakes and their fixes.
// ---------------------------------------------------------------------------

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 06",
      title: "Common Pitfalls",
      subtitle:
          "Patterns that produce silent or confusing input behavior, with "
          "the root cause and a recommended fix for each.",
      accent: _accentRose,
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: <Widget>[
          for (final _Pitfall p in _pitfalls) _PitfallCard(pitfall: p),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.pitfall});

  final _Pitfall pitfall;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            pitfall.tint.withValues(alpha: 0.22),
            _bgCard,
            pitfall.tint.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: pitfall.tint.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: pitfall.tint, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  pitfall.title,
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _PitfallSection(label: "SYMPTOM", body: pitfall.symptom, color: _warnAmber),
          SizedBox(height: 8),
          _PitfallSection(label: "CAUSE", body: pitfall.cause, color: _errRed),
          SizedBox(height: 8),
          _PitfallSection(label: "FIX", body: pitfall.fix, color: _okGreen),
        ],
      ),
    );
  }
}

class _PitfallSection extends StatelessWidget {
  const _PitfallSection({
    required this.label,
    required this.body,
    required this.color,
  });

  final String label;
  final String body;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 3),
        Text(
          body,
          style: TextStyle(
            color: _textSecondary,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _ApiSurfaceSection -- compact API reference for HitTest* symbols.
// ---------------------------------------------------------------------------

class _ApiSurfaceSection extends StatelessWidget {
  const _ApiSurfaceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 07",
      title: "API Surface",
      subtitle:
          "The concrete symbols from package:flutter/rendering.dart that "
          "implement the pipeline.",
      accent: _accentEmerald,
      child: Container(
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _borderSoft),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _accentEmerald.withValues(alpha: 0.22),
                    _accentTeal.withValues(alpha: 0.10),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: const <Widget>[
                  _MxCell(text: "Symbol", flex: 3, header: true),
                  _MxCell(text: "Kind", flex: 2, header: true),
                  _MxCell(text: "Signature", flex: 5, header: true),
                  _MxCell(text: "Purpose", flex: 6, header: true),
                ],
              ),
            ),
            for (final _ApiEntry e in _apiSurface) _ApiRow(entry: e),
          ],
        ),
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({required this.entry});

  final _ApiEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: _borderSoft)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                entry.symbol,
                style: TextStyle(
                  color: _accentEmerald,
                  fontSize: 12,
                  fontFamily: "monospace",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: _Pill(text: entry.kind, color: _accentTeal),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                entry.signature,
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 12,
                  fontFamily: "monospace",
                  height: 1.4,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                entry.purpose,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _GlossarySection -- vocabulary panel.
// ---------------------------------------------------------------------------

class _GlossarySection extends StatelessWidget {
  const _GlossarySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 08",
      title: "Glossary",
      subtitle: "Bite-sized definitions for vocabulary used in this atlas.",
      accent: _accentTeal,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          for (final String entry in _glossary) _GlossaryCard(text: entry),
        ],
      ),
    );
  }
}

class _GlossaryCard extends StatelessWidget {
  const _GlossaryCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final int colonIndex = text.indexOf(":");
    final String term = colonIndex >= 0 ? text.substring(0, colonIndex) : text;
    final String body = colonIndex >= 0 ? text.substring(colonIndex + 1).trim() : "";
    return Container(
      width: 290,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _accentTeal.withValues(alpha: 0.16),
            _bgCard,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _accentTeal.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            term,
            style: TextStyle(
              color: _accentTeal,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: "monospace",
            ),
          ),
          SizedBox(height: 4),
          Text(
            body,
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ChecklistSection -- short checklist for code review.
// ---------------------------------------------------------------------------

class _ChecklistSection extends StatelessWidget {
  const _ChecklistSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      tag: "STAGE 09",
      title: "Review Checklist",
      subtitle:
          "Items to confirm when designing or auditing a widget tree that "
          "relies on the hit-test pipeline.",
      accent: _accentLime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _BulletLine(
            text: "Every interactive surface has a non-null background or "
                "an explicit HitTestBehavior set.",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Stacked overlays use translucent or IgnorePointer so the "
                "primary control underneath remains reachable.",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Positioned children are sized so their hit region stays "
                "inside the parent's bounds.",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Choice between Listener and GestureDetector is "
                "intentional; both are not stacked on the same node by "
                "accident.",
            color: _accentLime,
          ),
          _BulletLine(
            text: "AbsorbPointer vs IgnorePointer choice matches the intent "
                "(barrier vs invisible).",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Custom RenderObject implementations override hitTestSelf "
                "AND hitTestChildren consistently.",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Hit-test order in Stack matches z-order expectations "
                "(reverse paint order).",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Semantics are explicitly controlled when using "
                "AbsorbPointer / IgnorePointer (ignoringSemantics arg).",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Recognizer composition (TapGestureRecognizer etc.) is "
                "verified in the gesture arena, not assumed.",
            color: _accentLime,
          ),
          _BulletLine(
            text: "Pointer streams from Listener are bounded; avoid "
                "leaking unbounded state inside event handlers.",
            color: _accentLime,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _FooterSection -- closing card.
// ---------------------------------------------------------------------------

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18, 12, 18, 24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _accentIndigo.withValues(alpha: 0.18),
            _accentViolet.withValues(alpha: 0.14),
            _bgPanel,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.bookmark_added_rounded, color: _accentIndigo, size: 22),
              SizedBox(width: 10),
              Text(
                "End of atlas",
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "This script is a STATIC visualization. It builds a single "
            "MaterialApp snapshot of the hit-testing pipeline so that "
            "downstream AST tools can serialize, inspect, and replay it "
            "without ever needing to register a pointer event.",
            style: TextStyle(
              color: _textSecondary,
              fontSize: 13,
              height: 1.55,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _Pill(text: "static-snapshot", color: _accentCyan),
              _Pill(text: "no-state", color: _accentBlue),
              _Pill(text: "no-async", color: _accentIndigo),
              _Pill(text: "analyzer-clean", color: _accentEmerald, icon: Icons.check_rounded),
              _Pill(text: "hand-authored", color: _accentAmber),
            ],
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _bgCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _borderSoft),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info_outline_rounded, color: _infoBlue, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "For interactive exploration of the same pipeline, see "
                    "render_pointer_listener_test.dart and "
                    "render_pointer_test.dart in this same folder.",
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 12,
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

// ---------------------------------------------------------------------------
// Top-level entry point. Composes the atlas into a single MaterialApp.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Hit-Test Pipeline Atlas",
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bgRoot,
      colorScheme: ColorScheme.dark(
        primary: _accentIndigo,
        secondary: _accentCyan,
        surface: _bgPanel,
      ),
      fontFamily: "Roboto",
    ),
    home: Scaffold(
      backgroundColor: _bgRoot,
      appBar: AppBar(
        backgroundColor: _bgPanel,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _accentCyan,
                    _accentIndigo,
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.touch_app_rounded, color: Colors.white, size: 18),
            ),
            SizedBox(width: 10),
            Text(
              "Hit-Test Pipeline Atlas",
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _accentEmerald.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _accentEmerald.withValues(alpha: 0.5)),
              ),
              child: Text(
                "STATIC",
                style: TextStyle(
                  color: _accentEmerald,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            _IntroSection(),
            _PipelineOverviewSection(),
            _BehaviorMatrixSection(),
            _LayeredExampleSection(),
            _AbsorbIgnoreSection(),
            _JourneyTraceSection(),
            _PitfallsSection(),
            _ApiSurfaceSection(),
            _GlossarySection(),
            _ChecklistSection(),
            _FooterSection(),
          ],
        ),
      ),
    ),
  );
}
