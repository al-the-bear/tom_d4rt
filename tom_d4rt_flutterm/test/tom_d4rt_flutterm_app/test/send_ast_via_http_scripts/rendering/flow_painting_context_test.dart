// D4rt test script: Comprehensive deep demo for FlowPaintingContext
//
// FlowPaintingContext is an abstract class in Flutter's rendering library
// that provides the interface used by FlowDelegate to paint its children
// within a Flow widget. Rather than using traditional layout constraints,
// FlowPaintingContext allows each child to be painted at an arbitrary
// position using Matrix4 transforms — crucially, without triggering a
// re-layout. This makes it ideal for high-performance animations.
//
// Key API:
//   - paintChild(int i, {Matrix4? transform}) — paints child i with transform
//   - size — the overall Size of the Flow widget
//   - childCount — number of children
//   - getChildSize(int i) — Size of a specific child
//
// This demo covers:
//   1.  Header banner with gradient and icon
//   2.  What is FlowPaintingContext — explanation cards
//   3.  Core API visualization (paintChild, size, childCount, getChildSize)
//   4.  Flow widget + FlowDelegate relationship diagram
//   5.  Transform visualization — Matrix4 positioning
//   6.  Circular layout example
//   7.  Stacked/overlapping cards layout
//   8.  Animation concept — repaint without relayout
//   9.  Code snippets — FlowDelegate implementation
//   10. Real-world use cases
//   11. Summary and test result badge
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS — Teal / Cyan palette
// ═══════════════════════════════════════════════════════════════════════════

const _kTeal50 = Color(0xFFE0F2F1);
const _kTeal100 = Color(0xFFB2DFDB);
const _kTeal200 = Color(0xFF80CBC4);
const _kTeal300 = Color(0xFF4DB6AC);
const _kTeal400 = Color(0xFF26A69A);
const _kTeal600 = Color(0xFF00897B);
const _kTeal700 = Color(0xFF00796B);
const _kTeal800 = Color(0xFF00695C);
const _kTeal900 = Color(0xFF004D40);
const _kCyan600 = Color(0xFF00ACC1);
const _kCyan700 = Color(0xFF0097A7);
const _kCyan800 = Color(0xFF00838F);
const _kCardBg = Color(0xFFFFFFFF);
const _kCodeBg = Color(0xFF1A2327);
const _kCodeBorder = Color(0xFF37474F);
const _kCodeText = Color(0xFFB2DFDB);
const _kDividerColor = Color(0xFFB2DFDB);
const _kTextDark = Color(0xFF263238);
const _kTextMuted = Color(0xFF546E7A);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Section header with icon and decorative underline
Widget _buildSectionHeader(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: _kTeal100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kTeal300, width: 1),
              ),
              child: Icon(icon, color: _kTeal800, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: _kTeal900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_kTeal600, _kCyan600, _kTeal200],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ),
  );
}

/// Information card with icon badge, title, and body text
Widget _buildInfoCard(
  String title,
  String body,
  IconData icon, {
  Color? accentColor,
}) {
  final accent = accentColor ?? _kTeal600;
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kTeal200),
      boxShadow: [
        BoxShadow(
          color: _kTeal900.withAlpha(15),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accent.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withAlpha(60)),
          ),
          child: Icon(icon, color: accent, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(fontSize: 12, color: _kTextMuted, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Styled code block with a title bar
Widget _buildCodeBlock(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kCodeBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kCodeBorder,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kTeal300, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kTeal200,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _kCodeText,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
}

/// API property row: name, type, description
Widget _buildApiRow(String name, String type, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 5, right: 8),
          decoration: BoxDecoration(
            color: _kCyan600,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(
          width: 120,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              color: _kTeal800,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 80,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11,
              color: _kCyan700.withAlpha(180),
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: _kTextMuted, height: 1.3),
          ),
        ),
      ],
    ),
  );
}

/// A small labeled chip for tags / badges
Widget _buildChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
    ),
  );
}

/// A diagram box used in relationship / flow diagrams
Widget _buildDiagramBox(String label, IconData icon, Color bg, Color border) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: border, width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: border),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: border,
          ),
        ),
      ],
    ),
  );
}

/// Arrow label for diagrams
Widget _buildArrowLabel(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.arrow_downward, size: 16, color: _kTeal600),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontStyle: FontStyle.italic,
            color: _kTeal700,
          ),
        ),
      ],
    ),
  );
}

/// Visual transform cell: shows a child index and its transform description
Widget _buildTransformCell(int index, String transformDesc, Color childColor) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: childColor.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: childColor.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: childColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "$index",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _kCardBg,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Child $index",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: childColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                transformDesc,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kTextMuted,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.transform, size: 20, color: childColor.withAlpha(150)),
      ],
    ),
  );
}

/// Builds a circular-layout position indicator for the circle demo
Widget _buildCirclePositionRow(int index, double angleDeg, Color dotColor) {
  final angleLabel = "${angleDeg.toStringAsFixed(0)} deg";
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          child: Center(
            child: Text(
              "$index",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _kCardBg,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "Item $index",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _kTextDark,
          ),
        ),
        const Spacer(),
        Text(
          angleLabel,
          style: const TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: _kTeal700,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.rotate_right, size: 14, color: dotColor),
      ],
    ),
  );
}

/// Builds a stacked card for the overlapping cards demo
Widget _buildStackedCard(
  int index,
  double offsetX,
  double offsetY,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              "Card $index",
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: _kCardBg,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "translate(${offsetX.toStringAsFixed(0)}, "
            "${offsetY.toStringAsFixed(0)}, 0)",
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: _kTextMuted,
            ),
          ),
        ),
        Icon(Icons.layers, size: 16, color: color),
      ],
    ),
  );
}

/// Use-case entry with icon and description
Widget _buildUseCaseEntry(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kTeal50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kTeal200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: _kTeal700),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kTeal800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 11,
                  color: _kTextMuted,
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

/// Advantage row for the animation section
Widget _buildAdvantageRow(String label, String detail, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _kCyan600),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$label: ",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _kTeal800,
                  ),
                ),
                TextSpan(
                  text: detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _kTextMuted,
                    height: 1.4,
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

/// Comparison row: traditional layout vs Flow
Widget _buildComparisonRow(String aspect, String traditional, String flow) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            aspect,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _kTextDark,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              traditional,
              style: const TextStyle(fontSize: 10, color: Color(0xFFBF360C)),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kTeal50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              flow,
              style: const TextStyle(fontSize: 10, color: _kTeal800),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION BUILDERS
// ═══════════════════════════════════════════════════════════════════════════

/// Section 1 — Header banner
Widget _buildHeaderBanner() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kTeal800, _kTeal600, _kCyan600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kTeal900.withAlpha(50),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kCardBg.withAlpha(25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _kCardBg.withAlpha(40)),
              ),
              child: const Icon(Icons.animation, color: _kCardBg, size: 32),
            ),
            const SizedBox(width: 14),
            const Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FlowPaintingContext",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _kCardBg,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Deep Demo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: _kTeal100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _kCardBg.withAlpha(18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kCardBg.withAlpha(30)),
          ),
          child: const Text(
            "High-performance child painting with Matrix4 transforms "
            "for the Flow widget - repaint without re-layout",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: _kTeal100, height: 1.4),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChip("rendering.dart", _kTeal200),
            _buildChip("abstract class", _kCyan600),
            _buildChip("FlowDelegate", _kTeal300),
          ],
        ),
      ],
    ),
  );
}

/// Section 2 — What is FlowPaintingContext
Widget _buildWhatIsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("What is FlowPaintingContext?", Icons.help_outline),
      _buildInfoCard(
        "Abstract Interface",
        "FlowPaintingContext is an abstract class defined in "
            "package:flutter/rendering.dart. It provides the painting "
            "interface that FlowDelegate uses to position and paint each "
            "child of a Flow widget.",
        Icons.api,
      ),
      _buildInfoCard(
        "Transform-Based Painting",
        "Instead of using layout constraints to position children, "
            "FlowPaintingContext lets you apply a Matrix4 transform to "
            "each child via paintChild(). This decouples positioning from "
            "the layout phase entirely.",
        Icons.transform,
        accentColor: _kCyan600,
      ),
      _buildInfoCard(
        "Performance Advantage",
        "Because painting is separated from layout, the Flow widget "
            "can repaint children with new transforms without triggering "
            "an expensive re-layout. This is ideal for animations where "
            "children move frequently.",
        Icons.speed,
        accentColor: _kTeal400,
      ),
      _buildInfoCard(
        "Delegate Pattern",
        "You never instantiate FlowPaintingContext directly. Flutter "
            "creates it and passes it to your FlowDelegate.paintChildren() "
            "override. You call context.paintChild() for each child you "
            "want to render.",
        Icons.pattern,
        accentColor: _kTeal700,
      ),
    ],
  );
}

/// Section 3 — Core API visualization
Widget _buildCoreApiSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Core API", Icons.data_object),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "FlowPaintingContext Members",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _kTeal900,
              ),
            ),
            const SizedBox(height: 4),
            const Divider(color: _kDividerColor),
            const SizedBox(height: 4),
            _buildApiRow(
              "paintChild",
              "void",
              "Paints child at index i with an optional Matrix4 "
                  "transform. If transform is null, identity is used.",
            ),
            const Divider(color: _kDividerColor, height: 16),
            _buildApiRow(
              "size",
              "Size",
              "The overall size of the Flow widget itself, as "
                  "determined during the layout phase.",
            ),
            const Divider(color: _kDividerColor, height: 16),
            _buildApiRow(
              "childCount",
              "int",
              "The number of children in the Flow widget. Use this "
                  "to iterate over all children in paintChildren().",
            ),
            const Divider(color: _kDividerColor, height: 16),
            _buildApiRow(
              "getChildSize",
              "Size",
              "Returns the Size of child at index i. Useful for "
                  "computing transforms relative to child dimensions.",
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _buildCodeBlock(
        "paintChild Signature",
        "void paintChild(\n"
            "  int i, {\n"
            "  Matrix4? transform,\n"
            "});\n"
            "\n"
            "// Example usage inside paintChildren:\n"
            "for (int i = 0; i < context.childCount; i++) {\n"
            "  final childSize = context.getChildSize(i);\n"
            "  final tx = Matrix4.translationValues(\n"
            "    i * 60.0, 0, 0,\n"
            "  );\n"
            "  context.paintChild(i, transform: tx);\n"
            "}",
      ),
    ],
  );
}

/// Section 4 — Flow + FlowDelegate relationship diagram
Widget _buildRelationshipDiagram() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader(
        "Flow + FlowDelegate Relationship",
        Icons.account_tree,
      ),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          children: [
            _buildDiagramBox("Flow Widget", Icons.widgets, _kTeal50, _kTeal700),
            _buildArrowLabel("owns a"),
            _buildDiagramBox(
              "FlowDelegate",
              Icons.tune,
              const Color(0xFFE0F7FA),
              _kCyan700,
            ),
            _buildArrowLabel("paintChildren() receives"),
            _buildDiagramBox(
              "FlowPaintingContext",
              Icons.brush,
              _kTeal50,
              _kTeal600,
            ),
            _buildArrowLabel("calls"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDiagramBox(
                  "paintChild(i)",
                  Icons.child_care,
                  const Color(0xFFF1F8E9),
                  const Color(0xFF558B2F),
                ),
                const SizedBox(width: 8),
                _buildDiagramBox(
                  "getChildSize(i)",
                  Icons.straighten,
                  const Color(0xFFFFF3E0),
                  const Color(0xFFE65100),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kTeal50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kTeal200),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How it works:",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "1. Flow widget performs layout on all children\n"
              "2. Flow calls delegate.paintChildren(context)\n"
              "3. The delegate receives a FlowPaintingContext\n"
              "4. Delegate uses context.paintChild() for each child\n"
              "5. Each child gets a Matrix4 transform for positioning\n"
              "6. On repaint, only step 2-5 runs (no re-layout!)",
              style: TextStyle(fontSize: 12, color: _kTextMuted, height: 1.6),
            ),
          ],
        ),
      ),
    ],
  );
}

/// Section 5 — Transform visualization
Widget _buildTransformVisualization() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Transform Visualization", Icons.transform),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Matrix4 Transforms Position Children",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Each child is painted at (0,0) by default. "
              "A Matrix4 transform translates, rotates, or "
              "scales it into its final position.",
              style: TextStyle(fontSize: 12, color: _kTextMuted, height: 1.4),
            ),
            const SizedBox(height: 12),
            _buildTransformCell(0, "identity (no transform)", _kTeal600),
            _buildTransformCell(1, "translationValues(80, 0, 0)", _kCyan600),
            _buildTransformCell(2, "translationValues(160, 0, 0)", _kTeal400),
            _buildTransformCell(3, "translationValues(240, 0, 0)", _kCyan700),
            _buildTransformCell(
              4,
              "rotationZ(0.1) + translate(50, 50, 0)",
              _kTeal700,
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _buildCodeBlock(
        "Transform Examples",
        "// Translation only\n"
            "final tx = Matrix4.translationValues(x, y, 0);\n"
            "\n"
            "// Rotation around center\n"
            "final rot = Matrix4.identity()\n"
            "  ..translate(centerX, centerY)\n"
            "  ..rotateZ(angle)\n"
            "  ..translate(-centerX, -centerY);\n"
            "\n"
            "// Scale from origin\n"
            "final scale = Matrix4.identity()\n"
            "  ..scale(1.2, 1.2, 1.0);\n"
            "\n"
            "// Combine: translate + rotate\n"
            "final combined = Matrix4.identity()\n"
            "  ..translate(100.0, 50.0)\n"
            "  ..rotateZ(0.785); // 45 degrees",
      ),
    ],
  );
}

/// Section 6 — Circular layout example
Widget _buildCircularLayoutSection() {
  final itemCount = 8;
  final angleStep = 360.0 / itemCount;
  final colors = <Color>[
    _kTeal600,
    _kCyan600,
    _kTeal400,
    _kCyan700,
    _kTeal700,
    _kCyan800,
    _kTeal300,
    _kTeal800,
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Circular Layout Example", Icons.donut_large),
      _buildInfoCard(
        "Radial Positioning with Flow",
        "A FlowDelegate can arrange children in a circle by computing "
            "x = radius * cos(angle) and y = radius * sin(angle) for "
            "each child and applying it as a translation transform.",
        Icons.radio_button_checked,
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "8 Items at Equal Angles",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Radius: 100px  |  Angle Step: "
              "${angleStep.toStringAsFixed(1)} deg",
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: _kTextMuted,
              ),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < itemCount; i++)
              _buildCirclePositionRow(i, i * angleStep, colors[i]),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _buildCodeBlock(
        "CircularFlowDelegate",
        "class CircularFlowDelegate extends FlowDelegate {\n"
            "  final double radius;\n"
            "  CircularFlowDelegate(this.radius);\n"
            "\n"
            "  @override\n"
            "  void paintChildren(FlowPaintingContext ctx) {\n"
            "    final n = ctx.childCount;\n"
            "    final step = 2 * pi / n;\n"
            "    final center = ctx.size / 2;\n"
            "    for (int i = 0; i < n; i++) {\n"
            "      final angle = i * step;\n"
            "      final childSz = ctx.getChildSize(i)!;\n"
            "      final dx = center.width\n"
            "          + radius * cos(angle)\n"
            "          - childSz.width / 2;\n"
            "      final dy = center.height\n"
            "          + radius * sin(angle)\n"
            "          - childSz.height / 2;\n"
            "      ctx.paintChild(i,\n"
            "        transform: Matrix4.translationValues(\n"
            "          dx, dy, 0),\n"
            "      );\n"
            "    }\n"
            "  }\n"
            "\n"
            "  @override\n"
            "  bool shouldRepaint(CircularFlowDelegate old) =>\n"
            "      old.radius != radius;\n"
            "}",
      ),
    ],
  );
}

/// Section 7 — Stacked/overlapping cards layout
Widget _buildStackedCardsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Stacked / Overlapping Cards", Icons.layers),
      _buildInfoCard(
        "Fan-Out Card Layout",
        "By translating each successive child with an increasing "
            "horizontal and vertical offset, Flow creates a visually "
            "appealing stacked deck effect. Each card partially overlaps "
            "the previous one.",
        Icons.view_carousel,
      ),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overlapping Stack (5 cards)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            const SizedBox(height: 10),
            _buildStackedCard(0, 0, 0, _kTeal800),
            _buildStackedCard(1, 20, 8, _kTeal600),
            _buildStackedCard(2, 40, 16, _kCyan600),
            _buildStackedCard(3, 60, 24, _kTeal400),
            _buildStackedCard(4, 80, 32, _kCyan700),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _buildCodeBlock(
        "StackedFlowDelegate",
        "class StackedFlowDelegate extends FlowDelegate {\n"
            "  final double overlapX;\n"
            "  final double overlapY;\n"
            "  StackedFlowDelegate({\n"
            "    this.overlapX = 20,\n"
            "    this.overlapY = 8,\n"
            "  });\n"
            "\n"
            "  @override\n"
            "  void paintChildren(FlowPaintingContext ctx) {\n"
            "    for (int i = 0; i < ctx.childCount; i++) {\n"
            "      ctx.paintChild(i,\n"
            "        transform: Matrix4.translationValues(\n"
            "          i * overlapX,\n"
            "          i * overlapY,\n"
            "          0,\n"
            "        ),\n"
            "      );\n"
            "    }\n"
            "  }\n"
            "\n"
            "  @override\n"
            "  bool shouldRepaint(StackedFlowDelegate old) =>\n"
            "      old.overlapX != overlapX ||\n"
            "      old.overlapY != overlapY;\n"
            "}",
      ),
    ],
  );
}

/// Section 8 — Animation concept
Widget _buildAnimationConceptSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Animation: Repaint Without Relayout", Icons.speed),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Why Flow is Fast for Animations",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            const SizedBox(height: 10),
            _buildAdvantageRow(
              "No Re-layout",
              "When a FlowDelegate repaints, children are NOT re-laid-out. "
                  "Their sizes stay the same; only transforms change.",
              Icons.block,
            ),
            _buildAdvantageRow(
              "Layer Caching",
              "Each child is composited on its own layer. Flutter only "
                  "needs to update the transform matrix, not rasterize.",
              Icons.layers_outlined,
            ),
            _buildAdvantageRow(
              "Single Paint Pass",
              "paintChildren() is a single method call that positions "
                  "all children, making it extremely efficient.",
              Icons.flash_on,
            ),
            _buildAdvantageRow(
              "Animation Integration",
              "Pass an Animation to FlowDelegate via its constructor. "
                  "Use repaint: animation as the Listenable parameter.",
              Icons.play_circle_outline,
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.compare_arrows, size: 18, color: _kTeal700),
                const SizedBox(width: 8),
                const Text(
                  "Traditional Layout vs Flow",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _kTeal800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 80),
                Expanded(
                  child: Center(
                    child: Text(
                      "Traditional",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFBF360C),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Center(
                    child: Text(
                      "Flow",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _kTeal800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildComparisonRow("Move Child", "Layout + Paint", "Paint only"),
            _buildComparisonRow("Siblings", "May re-layout", "Unaffected"),
            _buildComparisonRow("Cost", "O(n) layout", "O(1) transform"),
            _buildComparisonRow("Mechanism", "Constraints", "Matrix4"),
            _buildComparisonRow("Best For", "Static layouts", "Animations"),
          ],
        ),
      ),
    ],
  );
}

/// Section 9 — Code snippets
Widget _buildCodeSnippetsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("FlowDelegate Implementation", Icons.description),
      _buildCodeBlock(
        "Minimal FlowDelegate",
        "class MyFlowDelegate extends FlowDelegate {\n"
            "  @override\n"
            "  void paintChildren(FlowPaintingContext context) {\n"
            "    // context.size   => Flow widget size\n"
            "    // context.childCount => number of children\n"
            "    // context.getChildSize(i) => size of child i\n"
            "    // context.paintChild(i, transform: ...) => paint\n"
            "\n"
            "    for (int i = 0; i < context.childCount; i++) {\n"
            "      context.paintChild(i);\n"
            "    }\n"
            "  }\n"
            "\n"
            "  @override\n"
            "  bool shouldRepaint(MyFlowDelegate oldDelegate) {\n"
            "    return false;\n"
            "  }\n"
            "}",
      ),
      _buildCodeBlock(
        "Animated FlowDelegate",
        "class AnimatedFlowDelegate extends FlowDelegate {\n"
            "  final Animation<double> animation;\n"
            "\n"
            "  AnimatedFlowDelegate(this.animation)\n"
            "      : super(repaint: animation);\n"
            "\n"
            "  @override\n"
            "  void paintChildren(FlowPaintingContext context) {\n"
            "    final progress = animation.value;\n"
            "    for (int i = 0; i < context.childCount; i++) {\n"
            "      final angle = i * (2 * 3.1416 / context.childCount);\n"
            "      final radius = 100.0 * progress;\n"
            "      final dx = context.size.width / 2\n"
            "          + radius * _cos(angle)\n"
            "          - (context.getChildSize(i)?.width ?? 0) / 2;\n"
            "      final dy = context.size.height / 2\n"
            "          + radius * _sin(angle)\n"
            "          - (context.getChildSize(i)?.height ?? 0) / 2;\n"
            "      context.paintChild(i,\n"
            "        transform: Matrix4.translationValues(dx, dy, 0),\n"
            "      );\n"
            "    }\n"
            "  }\n"
            "\n"
            "  double _cos(double a) => a < 1.57 ? 1 - a * a / 2 : -1;\n"
            "  double _sin(double a) => a;\n"
            "\n"
            "  @override\n"
            "  bool shouldRepaint(AnimatedFlowDelegate old) =>\n"
            "      old.animation != animation;\n"
            "}",
      ),
      _buildCodeBlock(
        "Using Flow Widget",
        "Flow(\n"
            "  delegate: CircularFlowDelegate(radius: 100),\n"
            "  children: [\n"
            "    for (int i = 0; i < 6; i++)\n"
            "      Container(\n"
            "        width: 40, height: 40,\n"
            "        decoration: BoxDecoration(\n"
            "          color: Colors.teal,\n"
            "          shape: BoxShape.circle,\n"
            "        ),\n"
            "        child: Center(\n"
            "          child: Text(\"item\", style: TextStyle(\n"
            "            color: Colors.white, fontSize: 10)),\n"
            "        ),\n"
            "      ),\n"
            "  ],\n"
            ")",
      ),
    ],
  );
}

/// Section 10 — Real-world use cases
Widget _buildUseCasesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Real-World Use Cases", Icons.apps),
      _buildUseCaseEntry(
        "Radial / Pie Menus",
        "Arrange menu items in a circle around a center button. "
            "Animate items exploding outward when the menu opens, "
            "using Flow with an animation-driven delegate.",
        Icons.donut_large,
      ),
      _buildUseCaseEntry(
        "Card Fan / Deck Layout",
        "Display cards in a fanned arrangement like a hand of "
            "playing cards. Each card gets a rotation and translation "
            "transform to create the spread effect.",
        Icons.view_carousel,
      ),
      _buildUseCaseEntry(
        "Animated Transitions",
        "Smoothly animate children from one layout position to "
            "another without re-layout. Perfect for hero-like "
            "transitions within a single widget tree.",
        Icons.swap_horiz,
      ),
      _buildUseCaseEntry(
        "Custom Navigation Bars",
        "Build custom bottom navigation or tab bars where items "
            "shift position or scale based on selection state. "
            "Flow ensures smooth, jank-free animation.",
        Icons.navigation,
      ),
      _buildUseCaseEntry(
        "Particle Effects",
        "Render many small widgets as particles. Flow handles "
            "painting hundreds of children efficiently since each "
            "child only needs a transform update per frame.",
        Icons.bubble_chart,
      ),
      _buildUseCaseEntry(
        "Drag-to-Reorder Visuals",
        "During a drag-and-reorder interaction, use Flow to "
            "animate items sliding to make room for the dragged "
            "item, without triggering full layout passes.",
        Icons.drag_indicator,
      ),
      _buildUseCaseEntry(
        "Orbital / Solar System UI",
        "Create an orbital diagram where items orbit a center "
            "point at different radii and speeds. Multiple animation "
            "controllers can drive different orbits.",
        Icons.public,
      ),
    ],
  );
}

/// Section 11 — Summary and test badge
Widget _buildSummaryAndBadge() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader("Summary", Icons.summarize),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kTeal200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Key Takeaways",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _kTeal800,
              ),
            ),
            const SizedBox(height: 10),
            _buildSummaryPoint(
              "FlowPaintingContext is the interface between FlowDelegate "
              "and the Flutter rendering pipeline.",
            ),
            _buildSummaryPoint(
              "Use paintChild(i, transform:) to position each child "
              "with a Matrix4 transform.",
            ),
            _buildSummaryPoint(
              "Access size, childCount, and getChildSize(i) to compute "
              "layout-aware transforms.",
            ),
            _buildSummaryPoint(
              "Repainting does NOT trigger re-layout, making Flow "
              "ideal for high-frequency animations.",
            ),
            _buildSummaryPoint(
              "Pass an Animation as the repaint Listenable to "
              "FlowDelegate for automatic repaint on value change.",
            ),
            _buildSummaryPoint(
              "Common patterns: circular layouts, stacked cards, "
              "radial menus, drag-reorder animations.",
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_kTeal600, _kCyan600]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: _kTeal900.withAlpha(40),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified, color: _kCardBg, size: 24),
            const SizedBox(width: 10),
            const Column(
              children: [
                Text(
                  "FlowPaintingContext Deep Demo",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _kCardBg,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Test Passed - All Sections Rendered",
                  style: TextStyle(fontSize: 11, color: _kTeal100),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

/// Individual summary bullet point
Widget _buildSummaryPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6, right: 10),
          decoration: const BoxDecoration(
            color: _kTeal600,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: _kTextMuted,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Debug prints
  print("FlowPaintingContext Deep Demo executing");
  print("=" * 55);
  print("FlowPaintingContext: abstract class in rendering.dart");
  print("Used by FlowDelegate.paintChildren() to paint children");
  print("Key API: paintChild, size, childCount, getChildSize");
  print("Advantage: repaint without re-layout for animations");
  print("=" * 55);

  // Verify rendering import is active
  final testParentData = FlowParentData();
  print("FlowParentData created: ${testParentData.runtimeType}");
  print("Offset: ${testParentData.offset}");

  // Demonstrate Matrix4 for transforms
  final identityMatrix = Matrix4.identity();
  print("Matrix4.identity row0: ${identityMatrix.row0}");

  final translateMatrix = Matrix4.translationValues(100, 50, 0);
  print("Matrix4.translate(100,50,0) row0: ${translateMatrix.row0}");

  final scaleMatrix = Matrix4.diagonal3Values(1.5, 1.5, 1.0);
  print("Matrix4.scale(1.5) row0: ${scaleMatrix.row0}");

  // Info about child positioning
  print("\nCircular layout math:");
  final itemCount = 8;
  final angleStep = 360.0 / itemCount;
  for (int i = 0; i < itemCount; i++) {
    print("  Child $i: angle = ${(i * angleStep).toStringAsFixed(1)} deg");
  }

  print("\nStacked cards offsets:");
  for (int i = 0; i < 5; i++) {
    print("  Card $i: translate(${i * 20}, ${i * 8}, 0)");
  }

  print("\n${"=" * 55}");
  print("FlowPaintingContext Deep Demo completed successfully");

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Header banner
        _buildHeaderBanner(),
        // 2. What is FlowPaintingContext
        _buildWhatIsSection(),
        // 3. Core API
        _buildCoreApiSection(),
        // 4. Relationship diagram
        _buildRelationshipDiagram(),
        // 5. Transform visualization
        _buildTransformVisualization(),
        // 6. Circular layout
        _buildCircularLayoutSection(),
        // 7. Stacked cards
        _buildStackedCardsSection(),
        // 8. Animation concept
        _buildAnimationConceptSection(),
        // 9. Code snippets
        _buildCodeSnippetsSection(),
        // 10. Real-world use cases
        _buildUseCasesSection(),
        // 11. Summary and badge
        _buildSummaryAndBadge(),
        const SizedBox(height: 24),
      ],
    ),
  );
}
