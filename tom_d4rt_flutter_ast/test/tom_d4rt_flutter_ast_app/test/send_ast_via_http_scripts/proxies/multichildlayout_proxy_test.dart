// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: DEEP DEMO - MultiChildLayoutDelegate / CustomMultiChildLayout / LayoutId
//
// This script is a hand-authored, visually rich exploration of Flutter's
// `CustomMultiChildLayout` widget and the `MultiChildLayoutDelegate` it
// orchestrates. It defines five distinct delegate subclasses at file scope,
// each demonstrating a different real-world layout pattern: dashboards, chat
// bubbles, puzzle solvers, postcards, and responsive splits. Together they
// illustrate the full surface area of the API: `performLayout`, `getSize`,
// `hasChild`, `layoutChild`, `positionChild`, and `shouldRelayout`.
//
// `CustomMultiChildLayout` is the right tool when:
//   * You have a fixed, known set of children identified by `LayoutId`.
//   * Each child's size depends on parent constraints (so `Stack` + `Positioned`
//     is awkward because `Positioned` only constrains, it doesn't measure).
//   * You want children to coordinate (e.g. a footer that knows the header's
//     height to compute its own offset).
//
// `Stack` works when children are independent and you can express positions
// in terms of fractions or pixel offsets. `CustomMultiChildLayout` shines
// when one child's geometry feeds another's.

import 'package:flutter/material.dart';

// =============================================================================
// FILE-SCOPE LAYOUT IDS
// =============================================================================
// Using string ids keeps the demo data-driven; in production you'd typically
// use enums for compile-time safety. We include both flavors below.

const String kIdHeader = 'header';
const String kIdSidebar = 'sidebar';
const String kIdMain = 'main';
const String kIdFooter = 'footer';

const String kIdAvatar = 'avatar';
const String kIdContent = 'content';
const String kIdTimestamp = 'timestamp';
const String kIdTail = 'tail';

const String kIdBoard = 'board';
const String kIdPiece1 = 'piece-1';
const String kIdPiece2 = 'piece-2';
const String kIdPiece3 = 'piece-3';
const String kIdPiece4 = 'piece-4';

const String kIdStamp = 'stamp';
const String kIdAddress = 'address';
const String kIdImage = 'image';
const String kIdPostmark = 'postmark';

const String kIdLeftPane = 'left';
const String kIdRightPane = 'right';
const String kIdDivider = 'divider';

const String kIdCardTitle = 'card-title';
const String kIdCardBody = 'card-body';
const String kIdCardMeta = 'card-meta';
const String kIdCardButton = 'card-button';

const String kIdFrameTL = 'frame-tl';
const String kIdFrameTR = 'frame-tr';
const String kIdFrameBL = 'frame-bl';
const String kIdFrameBR = 'frame-br';
const String kIdBezelContent = 'bezel-content';

// =============================================================================
// DELEGATE 1: DASHBOARD LAYOUT
// =============================================================================
// Classic shell layout. The header gets a fixed slice of the top, the footer
// gets a fixed slice of the bottom, and the remaining vertical band is split
// horizontally between sidebar and main content. The footer knows about the
// header's height; the main pane knows about the sidebar's width.

class _DashboardLayoutDelegate extends MultiChildLayoutDelegate {
  _DashboardLayoutDelegate({
    required this.headerHeight,
    required this.sidebarWidth,
    required this.footerHeight,
  });

  final double headerHeight;
  final double sidebarWidth;
  final double footerHeight;

  @override
  void performLayout(Size size) {
    // Header spans the full width, fixed height.
    if (hasChild(kIdHeader)) {
      layoutChild(
        kIdHeader,
        BoxConstraints.tightFor(width: size.width, height: headerHeight),
      );
      positionChild(kIdHeader, Offset.zero);
    }

    final double bodyTop = headerHeight;
    final double bodyHeight = size.height - headerHeight - footerHeight;

    // Sidebar fills the body height.
    if (hasChild(kIdSidebar)) {
      layoutChild(
        kIdSidebar,
        BoxConstraints.tightFor(width: sidebarWidth, height: bodyHeight),
      );
      positionChild(kIdSidebar, Offset(0, bodyTop));
    }

    // Main fills the remainder.
    if (hasChild(kIdMain)) {
      layoutChild(
        kIdMain,
        BoxConstraints.tightFor(
          width: size.width - sidebarWidth,
          height: bodyHeight,
        ),
      );
      positionChild(kIdMain, Offset(sidebarWidth, bodyTop));
    }

    // Footer hugs the bottom.
    if (hasChild(kIdFooter)) {
      layoutChild(
        kIdFooter,
        BoxConstraints.tightFor(width: size.width, height: footerHeight),
      );
      positionChild(kIdFooter, Offset(0, size.height - footerHeight));
    }
  }

  @override
  bool shouldRelayout(covariant _DashboardLayoutDelegate oldDelegate) {
    return oldDelegate.headerHeight != headerHeight ||
        oldDelegate.sidebarWidth != sidebarWidth ||
        oldDelegate.footerHeight != footerHeight;
  }
}

// =============================================================================
// DELEGATE 2: CHAT BUBBLE LAYOUT
// =============================================================================
// A chat message arranges an avatar (left), bubble content (right of avatar),
// timestamp under the bubble, and a tail (small triangle). The content's
// width depends on the avatar's width. The timestamp is placed under the
// content; its right edge aligns with the content's right edge.

class _ChatBubbleLayoutDelegate extends MultiChildLayoutDelegate {
  _ChatBubbleLayoutDelegate({
    required this.gap,
    required this.alignRight,
  });

  final double gap;
  final bool alignRight;

  @override
  void performLayout(Size size) {
    Size avatarSize = Size.zero;
    if (hasChild(kIdAvatar)) {
      avatarSize = layoutChild(
        kIdAvatar,
        const BoxConstraints(maxWidth: 56, maxHeight: 56),
      );
    }

    final double bubbleMaxWidth =
        size.width - avatarSize.width - gap - 8;

    Size contentSize = Size.zero;
    if (hasChild(kIdContent)) {
      contentSize = layoutChild(
        kIdContent,
        BoxConstraints(maxWidth: bubbleMaxWidth, maxHeight: size.height - 24),
      );
    }

    Size timestampSize = Size.zero;
    if (hasChild(kIdTimestamp)) {
      timestampSize = layoutChild(
        kIdTimestamp,
        BoxConstraints(maxWidth: bubbleMaxWidth),
      );
    }

    Size tailSize = Size.zero;
    if (hasChild(kIdTail)) {
      tailSize = layoutChild(
        kIdTail,
        const BoxConstraints.tightFor(width: 10, height: 10),
      );
    }

    if (alignRight) {
      // Content sits at top-left of remaining space, avatar on the right.
      if (hasChild(kIdAvatar)) {
        positionChild(
          kIdAvatar,
          Offset(size.width - avatarSize.width, 0),
        );
      }
      if (hasChild(kIdContent)) {
        positionChild(
          kIdContent,
          Offset(size.width - avatarSize.width - gap - contentSize.width, 0),
        );
      }
      if (hasChild(kIdTimestamp)) {
        positionChild(
          kIdTimestamp,
          Offset(
            size.width - avatarSize.width - gap - timestampSize.width,
            contentSize.height + 4,
          ),
        );
      }
      if (hasChild(kIdTail)) {
        positionChild(
          kIdTail,
          Offset(
            size.width - avatarSize.width - gap + 2,
            contentSize.height - tailSize.height - 4,
          ),
        );
      }
    } else {
      if (hasChild(kIdAvatar)) {
        positionChild(kIdAvatar, Offset.zero);
      }
      if (hasChild(kIdContent)) {
        positionChild(kIdContent, Offset(avatarSize.width + gap, 0));
      }
      if (hasChild(kIdTimestamp)) {
        positionChild(
          kIdTimestamp,
          Offset(avatarSize.width + gap, contentSize.height + 4),
        );
      }
      if (hasChild(kIdTail)) {
        positionChild(
          kIdTail,
          Offset(
            avatarSize.width + gap - tailSize.width,
            contentSize.height - tailSize.height - 4,
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(covariant _ChatBubbleLayoutDelegate oldDelegate) {
    return oldDelegate.gap != gap || oldDelegate.alignRight != alignRight;
  }
}

// =============================================================================
// DELEGATE 3: PUZZLE SOLVER LAYOUT
// =============================================================================
// Demonstrates `getSize`: the delegate computes its own desired size based on
// a grid configuration and snaps each piece to a cell. Useful when you want
// the layout to be intrinsically sized rather than filling a parent.

class _PuzzleSolverLayoutDelegate extends MultiChildLayoutDelegate {
  _PuzzleSolverLayoutDelegate({
    required this.cellSize,
    required this.columns,
    required this.rows,
    required this.padding,
  });

  final double cellSize;
  final int columns;
  final int rows;
  final double padding;

  @override
  Size getSize(BoxConstraints constraints) {
    final double w = padding * 2 + columns * cellSize;
    final double h = padding * 2 + rows * cellSize;
    return constraints.constrain(Size(w, h));
  }

  @override
  void performLayout(Size size) {
    if (hasChild(kIdBoard)) {
      layoutChild(
        kIdBoard,
        BoxConstraints.tightFor(width: size.width, height: size.height),
      );
      positionChild(kIdBoard, Offset.zero);
    }

    void placePiece(String id, int col, int row) {
      if (!hasChild(id)) return;
      layoutChild(
        id,
        BoxConstraints.tightFor(
          width: cellSize - 8,
          height: cellSize - 8,
        ),
      );
      positionChild(
        id,
        Offset(
          padding + col * cellSize + 4,
          padding + row * cellSize + 4,
        ),
      );
    }

    placePiece(kIdPiece1, 0, 0);
    placePiece(kIdPiece2, columns - 1, 0);
    placePiece(kIdPiece3, 0, rows - 1);
    placePiece(kIdPiece4, columns - 1, rows - 1);
  }

  @override
  bool shouldRelayout(covariant _PuzzleSolverLayoutDelegate oldDelegate) {
    return oldDelegate.cellSize != cellSize ||
        oldDelegate.columns != columns ||
        oldDelegate.rows != rows ||
        oldDelegate.padding != padding;
  }
}

// =============================================================================
// DELEGATE 4: POSTCARD LAYOUT
// =============================================================================
// Decorative composition: an image fills most of the card, the address sits
// at the bottom-left, the stamp rides at the top-right, and a postmark
// overlays the upper-left of the address area. Demonstrates overlapping
// children and offsets that compose with each other.

class _PostcardLayoutDelegate extends MultiChildLayoutDelegate {
  _PostcardLayoutDelegate({required this.stampSize, required this.padding});

  final double stampSize;
  final double padding;

  @override
  void performLayout(Size size) {
    if (hasChild(kIdImage)) {
      layoutChild(
        kIdImage,
        BoxConstraints.tightFor(
          width: size.width,
          height: size.height * 0.62,
        ),
      );
      positionChild(kIdImage, Offset.zero);
    }

    if (hasChild(kIdStamp)) {
      layoutChild(
        kIdStamp,
        BoxConstraints.tightFor(width: stampSize, height: stampSize * 1.2),
      );
      positionChild(
        kIdStamp,
        Offset(size.width - stampSize - padding, padding),
      );
    }

    if (hasChild(kIdAddress)) {
      final double addrTop = size.height * 0.62 + padding;
      layoutChild(
        kIdAddress,
        BoxConstraints(
          maxWidth: size.width - padding * 2,
          maxHeight: size.height - addrTop - padding,
        ),
      );
      positionChild(kIdAddress, Offset(padding, addrTop));
    }

    if (hasChild(kIdPostmark)) {
      layoutChild(
        kIdPostmark,
        const BoxConstraints.tightFor(width: 64, height: 64),
      );
      positionChild(
        kIdPostmark,
        Offset(size.width - 64 - padding, size.height * 0.62 + padding - 12),
      );
    }
  }

  @override
  bool shouldRelayout(covariant _PostcardLayoutDelegate oldDelegate) {
    return oldDelegate.stampSize != stampSize ||
        oldDelegate.padding != padding;
  }
}

// =============================================================================
// DELEGATE 5: RESPONSIVE SPLIT LAYOUT
// =============================================================================
// At narrow widths the layout stacks vertically (left on top, right on
// bottom); at wide widths it splits horizontally with a divider in between.
// The breakpoint is a constructor parameter so `shouldRelayout` can react.

class _ResponsiveSplitLayoutDelegate extends MultiChildLayoutDelegate {
  _ResponsiveSplitLayoutDelegate({
    required this.breakpoint,
    required this.leftFraction,
    required this.dividerThickness,
  });

  final double breakpoint;
  final double leftFraction;
  final double dividerThickness;

  @override
  void performLayout(Size size) {
    final bool horizontal = size.width >= breakpoint;
    if (horizontal) {
      final double leftW =
          (size.width - dividerThickness) * leftFraction;
      final double rightW = size.width - dividerThickness - leftW;

      if (hasChild(kIdLeftPane)) {
        layoutChild(
          kIdLeftPane,
          BoxConstraints.tightFor(width: leftW, height: size.height),
        );
        positionChild(kIdLeftPane, Offset.zero);
      }
      if (hasChild(kIdDivider)) {
        layoutChild(
          kIdDivider,
          BoxConstraints.tightFor(
            width: dividerThickness,
            height: size.height,
          ),
        );
        positionChild(kIdDivider, Offset(leftW, 0));
      }
      if (hasChild(kIdRightPane)) {
        layoutChild(
          kIdRightPane,
          BoxConstraints.tightFor(width: rightW, height: size.height),
        );
        positionChild(
          kIdRightPane,
          Offset(leftW + dividerThickness, 0),
        );
      }
    } else {
      final double topH =
          (size.height - dividerThickness) * leftFraction;
      final double bottomH = size.height - dividerThickness - topH;

      if (hasChild(kIdLeftPane)) {
        layoutChild(
          kIdLeftPane,
          BoxConstraints.tightFor(width: size.width, height: topH),
        );
        positionChild(kIdLeftPane, Offset.zero);
      }
      if (hasChild(kIdDivider)) {
        layoutChild(
          kIdDivider,
          BoxConstraints.tightFor(
            width: size.width,
            height: dividerThickness,
          ),
        );
        positionChild(kIdDivider, Offset(0, topH));
      }
      if (hasChild(kIdRightPane)) {
        layoutChild(
          kIdRightPane,
          BoxConstraints.tightFor(width: size.width, height: bottomH),
        );
        positionChild(
          kIdRightPane,
          Offset(0, topH + dividerThickness),
        );
      }
    }
  }

  @override
  bool shouldRelayout(covariant _ResponsiveSplitLayoutDelegate oldDelegate) {
    return oldDelegate.breakpoint != breakpoint ||
        oldDelegate.leftFraction != leftFraction ||
        oldDelegate.dividerThickness != dividerThickness;
  }
}

// =============================================================================
// DELEGATE 6: NAMED-SLOT CARD LAYOUT (RECIPE)
// =============================================================================
// Recipe: replace `Stack` + `Positioned` with semantic, named slots. Title
// pinned to the top, body fills the middle, meta sits above the button on
// the bottom, button hugs the bottom-right corner.

class _NamedSlotCardLayoutDelegate extends MultiChildLayoutDelegate {
  _NamedSlotCardLayoutDelegate({required this.padding});

  final double padding;

  @override
  void performLayout(Size size) {
    Size titleSize = Size.zero;
    if (hasChild(kIdCardTitle)) {
      titleSize = layoutChild(
        kIdCardTitle,
        BoxConstraints(maxWidth: size.width - padding * 2),
      );
      positionChild(kIdCardTitle, Offset(padding, padding));
    }

    Size buttonSize = Size.zero;
    if (hasChild(kIdCardButton)) {
      buttonSize = layoutChild(
        kIdCardButton,
        const BoxConstraints(maxWidth: 140, maxHeight: 36),
      );
      positionChild(
        kIdCardButton,
        Offset(
          size.width - buttonSize.width - padding,
          size.height - buttonSize.height - padding,
        ),
      );
    }

    Size metaSize = Size.zero;
    if (hasChild(kIdCardMeta)) {
      metaSize = layoutChild(
        kIdCardMeta,
        BoxConstraints(maxWidth: size.width - padding * 2),
      );
      positionChild(
        kIdCardMeta,
        Offset(
          padding,
          size.height - buttonSize.height - padding - metaSize.height - 6,
        ),
      );
    }

    if (hasChild(kIdCardBody)) {
      final double bodyTop = padding + titleSize.height + 8;
      final double bodyBottom =
          size.height - buttonSize.height - padding - metaSize.height - 14;
      layoutChild(
        kIdCardBody,
        BoxConstraints(
          maxWidth: size.width - padding * 2,
          maxHeight: (bodyBottom - bodyTop).clamp(0, size.height),
        ),
      );
      positionChild(kIdCardBody, Offset(padding, bodyTop));
    }
  }

  @override
  bool shouldRelayout(covariant _NamedSlotCardLayoutDelegate oldDelegate) {
    return oldDelegate.padding != padding;
  }
}

// =============================================================================
// DELEGATE 7: BEZEL FRAME LAYOUT (RECIPE)
// =============================================================================
// Decorative frame composed of four corner pieces that hug the corners of
// the card with content centered inside. Demonstrates symmetric placement
// and how a delegate can be agnostic to corner-piece sizes.

class _BezelLayoutDelegate extends MultiChildLayoutDelegate {
  _BezelLayoutDelegate({required this.cornerSize, required this.inset});

  final double cornerSize;
  final double inset;

  @override
  void performLayout(Size size) {
    final BoxConstraints corner =
        BoxConstraints.tightFor(width: cornerSize, height: cornerSize);

    if (hasChild(kIdFrameTL)) {
      layoutChild(kIdFrameTL, corner);
      positionChild(kIdFrameTL, Offset(inset, inset));
    }
    if (hasChild(kIdFrameTR)) {
      layoutChild(kIdFrameTR, corner);
      positionChild(
        kIdFrameTR,
        Offset(size.width - cornerSize - inset, inset),
      );
    }
    if (hasChild(kIdFrameBL)) {
      layoutChild(kIdFrameBL, corner);
      positionChild(
        kIdFrameBL,
        Offset(inset, size.height - cornerSize - inset),
      );
    }
    if (hasChild(kIdFrameBR)) {
      layoutChild(kIdFrameBR, corner);
      positionChild(
        kIdFrameBR,
        Offset(
          size.width - cornerSize - inset,
          size.height - cornerSize - inset,
        ),
      );
    }

    if (hasChild(kIdBezelContent)) {
      final double contentInset = cornerSize + inset + 6;
      layoutChild(
        kIdBezelContent,
        BoxConstraints.tightFor(
          width: size.width - contentInset * 2,
          height: size.height - contentInset * 2,
        ),
      );
      positionChild(
        kIdBezelContent,
        Offset(contentInset, contentInset),
      );
    }
  }

  @override
  bool shouldRelayout(covariant _BezelLayoutDelegate oldDelegate) {
    return oldDelegate.cornerSize != cornerSize ||
        oldDelegate.inset != inset;
  }
}

// =============================================================================
// HELPER: SECTION CARD
// =============================================================================

Widget _section({
  required String title,
  required String description,
  required Color background,
  required Color titleColor,
  required Color descriptionColor,
  required Widget child,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Card(
      elevation: 2,
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(color: descriptionColor, height: 1.4),
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    ),
  );
}

Widget _bullet(String text, {Color color = const Color(0xFF334155)}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 13.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// BUILD: ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  const scriptName = 'proxies/multichildlayout_proxy_test.dart';
  print('$scriptName executing - MultiChildLayoutDelegate deep demo');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MultiChildLayoutDelegate Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF6366F1),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text('CustomMultiChildLayout Showcase'),
        backgroundColor: const Color(0xFF312E81),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // -------------------------------------------------------------
              // SECTION 1: INTRO CARD
              // -------------------------------------------------------------
              _section(
                title: '1. What & Why',
                description:
                    'CustomMultiChildLayout coordinates a fixed set of named '
                    'children identified by LayoutId. The delegate measures '
                    'and positions each child in performLayout(Size).',
                background: const Color(0xFFEEF2FF),
                titleColor: const Color(0xFF312E81),
                descriptionColor: const Color(0xFF1E1B4B),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bullet(
                      'hasChild(id) - guard before laying out optional slots.',
                      color: const Color(0xFF312E81),
                    ),
                    _bullet(
                      'layoutChild(id, constraints) - returns the chosen size.',
                      color: const Color(0xFF312E81),
                    ),
                    _bullet(
                      'positionChild(id, offset) - sets the child origin.',
                      color: const Color(0xFF312E81),
                    ),
                    _bullet(
                      'getSize(BoxConstraints) - optional, declares your own size.',
                      color: const Color(0xFF312E81),
                    ),
                    _bullet(
                      'shouldRelayout(old) - return true on parameter changes.',
                      color: const Color(0xFF312E81),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 2: DASHBOARD DELEGATE
              // -------------------------------------------------------------
              _section(
                title: '2. Dashboard Layout',
                description:
                    'Header, sidebar, main, footer arranged via a single '
                    'delegate that knows each slice geometry.',
                background: const Color(0xFFFFF7ED),
                titleColor: const Color(0xFF7C2D12),
                descriptionColor: const Color(0xFF7C2D12),
                child: SizedBox(
                  height: 280,
                  child: CustomMultiChildLayout(
                    delegate: _DashboardLayoutDelegate(
                      headerHeight: 48,
                      sidebarWidth: 90,
                      footerHeight: 32,
                    ),
                    children: [
                      LayoutId(
                        id: kIdHeader,
                        child: Container(
                          color: const Color(0xFFEA580C),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text(
                            'Header',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdSidebar,
                        child: Container(
                          color: const Color(0xFFFDBA74),
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text(
                            'Sidebar',
                            style: TextStyle(
                              color: Color(0xFF7C2D12),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdMain,
                        child: Container(
                          color: const Color(0xFFFFEDD5),
                          alignment: Alignment.center,
                          child: const Text(
                            'Main Content',
                            style: TextStyle(
                              color: Color(0xFF9A3412),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdFooter,
                        child: Container(
                          color: const Color(0xFFC2410C),
                          alignment: Alignment.center,
                          child: const Text(
                            'Footer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 3: CHAT BUBBLE DELEGATE (with toggle)
              // -------------------------------------------------------------
              StatefulBuilder(
                builder: (context, setState) {
                  bool alignRight = false;
                  return StatefulBuilder(
                    builder: (context, setInner) {
                      return _section(
                        title: '3. Chat Bubble Layout',
                        description:
                            'The bubble width depends on the avatar; the '
                            'timestamp anchors below the bubble. Toggle to '
                            'flip the orientation.',
                        background: const Color(0xFFECFEFF),
                        titleColor: const Color(0xFF155E75),
                        descriptionColor: const Color(0xFF155E75),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Align right'),
                                Switch(
                                  value: alignRight,
                                  onChanged: (v) {
                                    setInner(() => alignRight = v);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 130,
                              child: CustomMultiChildLayout(
                                delegate: _ChatBubbleLayoutDelegate(
                                  gap: 10,
                                  alignRight: alignRight,
                                ),
                                children: [
                                  LayoutId(
                                    id: kIdAvatar,
                                    child: const CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Color(0xFF06B6D4),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  LayoutId(
                                    id: kIdContent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFCFFAFE),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: const Text(
                                        'CustomMultiChildLayout lets each '
                                        'child influence its siblings.',
                                        style: TextStyle(
                                          color: Color(0xFF0E7490),
                                        ),
                                      ),
                                    ),
                                  ),
                                  LayoutId(
                                    id: kIdTimestamp,
                                    child: const Text(
                                      'just now',
                                      style: TextStyle(
                                        color: Color(0xFF0891B2),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  LayoutId(
                                    id: kIdTail,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFCFFAFE),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              // -------------------------------------------------------------
              // SECTION 4: PUZZLE SOLVER DELEGATE (uses getSize)
              // -------------------------------------------------------------
              _section(
                title: '4. Puzzle Solver - getSize override',
                description:
                    'getSize lets the delegate declare its own intrinsic '
                    'size; pieces snap to grid corners.',
                background: const Color(0xFFFEF3C7),
                titleColor: const Color(0xFF78350F),
                descriptionColor: const Color(0xFF78350F),
                // Even though `_PuzzleSolverLayoutDelegate.getSize` returns a
                // bounded `Size` via `constraints.constrain(...)`, we still box
                // the layout explicitly. The d4rt `MultiChildLayoutDelegate`
                // proxy does not always invoke the user `getSize` override
                // before the underlying `RenderCustomMultiChildLayoutBox` asks
                // for `constraints.biggest`, so leaving this in `Center` (which
                // forwards loose unbounded constraints) raised
                // "RenderCustomMultiChildLayoutBox given an infinite size"
                // followed by a 12-frame cascade through every descendant.
                child: Center(
                  child: SizedBox(
                    width: 280,
                    height: 220,
                    child: CustomMultiChildLayout(
                      delegate: _PuzzleSolverLayoutDelegate(
                      cellSize: 64,
                      columns: 4,
                      rows: 3,
                      padding: 8,
                    ),
                    children: [
                      LayoutId(
                        id: kIdBoard,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDE68A),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFB45309),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdPiece1,
                        child: _puzzlePiece('A', const Color(0xFFB45309)),
                      ),
                      LayoutId(
                        id: kIdPiece2,
                        child: _puzzlePiece('B', const Color(0xFFD97706)),
                      ),
                      LayoutId(
                        id: kIdPiece3,
                        child: _puzzlePiece('C', const Color(0xFFF59E0B)),
                      ),
                      LayoutId(
                        id: kIdPiece4,
                        child: _puzzlePiece('D', const Color(0xFF92400E)),
                      ),
                    ],
                    ),
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 5: POSTCARD DELEGATE
              // -------------------------------------------------------------
              _section(
                title: '5. Postcard Layout',
                description:
                    'Image, address, stamp and postmark composed with '
                    'overlapping offsets - hard to express with rows/columns.',
                background: const Color(0xFFFCE7F3),
                titleColor: const Color(0xFF9D174D),
                descriptionColor: const Color(0xFF9D174D),
                child: SizedBox(
                  height: 260,
                  child: CustomMultiChildLayout(
                    delegate: _PostcardLayoutDelegate(
                      stampSize: 44,
                      padding: 10,
                    ),
                    children: [
                      LayoutId(
                        id: kIdImage,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFB7185),
                                Color(0xFFF472B6),
                                Color(0xFFEC4899),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Greetings from Layout City',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdStamp,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            border: Border.all(
                              color: const Color(0xFF9D174D),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'PSTG',
                            style: TextStyle(
                              color: Color(0xFF9D174D),
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdAddress,
                        child: const Text(
                          'To: The Reader\n'
                          '  c/o Flutter Layout Lab\n'
                          '  Render Tree Lane',
                          style: TextStyle(
                            color: Color(0xFF831843),
                            height: 1.4,
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdPostmark,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFBE185D),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'MAIL',
                            style: TextStyle(
                              color: Color(0xFFBE185D),
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 6: RESPONSIVE SPLIT
              // -------------------------------------------------------------
              _section(
                title: '6. Responsive Split',
                description:
                    'Above the breakpoint the layout is horizontal; below '
                    'it stacks. A single delegate handles both directions.',
                background: const Color(0xFFE0F2FE),
                titleColor: const Color(0xFF075985),
                descriptionColor: const Color(0xFF075985),
                child: SizedBox(
                  height: 260,
                  child: CustomMultiChildLayout(
                    delegate: _ResponsiveSplitLayoutDelegate(
                      breakpoint: 480,
                      leftFraction: 0.4,
                      dividerThickness: 6,
                    ),
                    children: [
                      LayoutId(
                        id: kIdLeftPane,
                        child: Container(
                          color: const Color(0xFF7DD3FC),
                          alignment: Alignment.center,
                          child: const Text(
                            'Left / Top Pane',
                            style: TextStyle(
                              color: Color(0xFF075985),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      LayoutId(
                        id: kIdDivider,
                        child: const ColoredBox(
                          color: Color(0xFF0369A1),
                        ),
                      ),
                      LayoutId(
                        id: kIdRightPane,
                        child: Container(
                          color: const Color(0xFFBAE6FD),
                          alignment: Alignment.center,
                          child: const Text(
                            'Right / Bottom Pane',
                            style: TextStyle(
                              color: Color(0xFF075985),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 7: NAMED-SLOT CARD RECIPE
              // -------------------------------------------------------------
              _section(
                title: '7. Named-Slot Card (recipe)',
                description:
                    'A card where each region has a meaningful id - a '
                    'cleaner alternative to Stack + Positioned.',
                background: const Color(0xFFF5F3FF),
                titleColor: const Color(0xFF5B21B6),
                descriptionColor: const Color(0xFF5B21B6),
                child: SizedBox(
                  height: 200,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE9FE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomMultiChildLayout(
                      delegate: _NamedSlotCardLayoutDelegate(padding: 14),
                      children: [
                        LayoutId(
                          id: kIdCardTitle,
                          child: const Text(
                            'Quarterly Report',
                            style: TextStyle(
                              color: Color(0xFF4C1D95),
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        LayoutId(
                          id: kIdCardBody,
                          child: const Text(
                            'CustomMultiChildLayout shines when slots have '
                            'fixed semantic roles. Each region can be styled '
                            'independently while the delegate keeps geometry '
                            'consistent.',
                            style: TextStyle(
                              color: Color(0xFF6D28D9),
                              height: 1.5,
                            ),
                          ),
                        ),
                        LayoutId(
                          id: kIdCardMeta,
                          child: const Text(
                            'updated 2 minutes ago',
                            style: TextStyle(
                              color: Color(0xFF7C3AED),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        LayoutId(
                          id: kIdCardButton,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7C3AED),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Open'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 8: BEZEL FRAME RECIPE
              // -------------------------------------------------------------
              _section(
                title: '8. Bezel Frame (recipe)',
                description:
                    'Four corner pieces compose a decorative frame; content '
                    'is centered between them with automatic insets.',
                background: const Color(0xFFF0FDF4),
                titleColor: const Color(0xFF166534),
                descriptionColor: const Color(0xFF166534),
                child: SizedBox(
                  height: 230,
                  child: CustomMultiChildLayout(
                    delegate: _BezelLayoutDelegate(cornerSize: 28, inset: 6),
                    children: [
                      LayoutId(id: kIdFrameTL, child: _corner(true, true)),
                      LayoutId(id: kIdFrameTR, child: _corner(false, true)),
                      LayoutId(id: kIdFrameBL, child: _corner(true, false)),
                      LayoutId(id: kIdFrameBR, child: _corner(false, false)),
                      LayoutId(
                        id: kIdBezelContent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Bezel content - the delegate keeps me clear of '
                            'the corners regardless of viewport.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF14532D),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 9: SHOULD RELAYOUT TOGGLE
              // -------------------------------------------------------------
              StatefulBuilder(
                builder: (context, setState) {
                  double headerH = 48;
                  return StatefulBuilder(
                    builder: (context, setInner) {
                      return _section(
                        title: '9. shouldRelayout in action',
                        description:
                            'Adjusting the slider creates a new delegate; '
                            'shouldRelayout returns true so the children are '
                            're-measured.',
                        background: const Color(0xFFFEF2F2),
                        titleColor: const Color(0xFF991B1B),
                        descriptionColor: const Color(0xFF991B1B),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Header height: ${headerH.toStringAsFixed(0)}px',
                              style: const TextStyle(
                                color: Color(0xFF7F1D1D),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Slider(
                              min: 32,
                              max: 100,
                              value: headerH,
                              activeColor: const Color(0xFFDC2626),
                              onChanged: (v) {
                                setInner(() => headerH = v);
                              },
                            ),
                            SizedBox(
                              height: 200,
                              child: CustomMultiChildLayout(
                                delegate: _DashboardLayoutDelegate(
                                  headerHeight: headerH,
                                  sidebarWidth: 70,
                                  footerHeight: 24,
                                ),
                                children: [
                                  LayoutId(
                                    id: kIdHeader,
                                    child: Container(
                                      color: const Color(0xFFDC2626),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Header (${headerH.toStringAsFixed(0)})',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  LayoutId(
                                    id: kIdSidebar,
                                    child: Container(
                                      color: const Color(0xFFFCA5A5),
                                    ),
                                  ),
                                  LayoutId(
                                    id: kIdMain,
                                    child: Container(
                                      color: const Color(0xFFFEE2E2),
                                      alignment: Alignment.center,
                                      child: const Text('main'),
                                    ),
                                  ),
                                  LayoutId(
                                    id: kIdFooter,
                                    child: Container(
                                      color: const Color(0xFF991B1B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              // -------------------------------------------------------------
              // SECTION 10: PITFALLS
              // -------------------------------------------------------------
              _section(
                title: '10. Pitfalls',
                description:
                    'Common traps when authoring MultiChildLayoutDelegate '
                    'subclasses.',
                background: const Color(0xFFFFFBEB),
                titleColor: const Color(0xFF92400E),
                descriptionColor: const Color(0xFF92400E),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bullet(
                      'Every LayoutId MUST be passed to layoutChild exactly '
                      'once - missing it triggers an assertion in debug.',
                      color: const Color(0xFF92400E),
                    ),
                    _bullet(
                      'Calling positionChild without a preceding layoutChild '
                      'is also an assertion; layout always precedes position.',
                      color: const Color(0xFF92400E),
                    ),
                    _bullet(
                      'Use hasChild before measuring optional slots so the '
                      'delegate works with subsets of children.',
                      color: const Color(0xFF92400E),
                    ),
                    _bullet(
                      'shouldRelayout must compare every parameter that '
                      'influences layout - missing one freezes the UI.',
                      color: const Color(0xFF92400E),
                    ),
                    _bullet(
                      'Override getSize only when you need an intrinsic size; '
                      'the default returns constraints.biggest.',
                      color: const Color(0xFF92400E),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 11: LAYOUTID SHOWCASE
              // -------------------------------------------------------------
              _section(
                title: '11. LayoutId',
                description:
                    'LayoutId tags a child with an id (commonly a String or '
                    'an enum). The delegate looks up children by id - order '
                    'in the children list is irrelevant.',
                background: const Color(0xFFE0E7FF),
                titleColor: const Color(0xFF3730A3),
                descriptionColor: const Color(0xFF3730A3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bullet(
                      'String ids are convenient for prototypes - constants '
                      'avoid typos.',
                      color: const Color(0xFF3730A3),
                    ),
                    _bullet(
                      'Enum ids give compile-time safety and exhaustive '
                      'switches inside the delegate.',
                      color: const Color(0xFF3730A3),
                    ),
                    _bullet(
                      'A child is a LayoutId widget that wraps any other '
                      'widget; the wrapped widget is what actually gets sized.',
                      color: const Color(0xFF3730A3),
                    ),
                    _bullet(
                      'You can omit a slot at runtime - the delegate must use '
                      'hasChild to skip absent ids gracefully.',
                      color: const Color(0xFF3730A3),
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 12: DECISION CARD
              // -------------------------------------------------------------
              _section(
                title: '12. Decision Card',
                description:
                    'Choosing between Stack/Positioned, CustomMultiChildLayout, '
                    'Flow, and Wrap.',
                background: const Color(0xFFF8FAFC),
                titleColor: const Color(0xFF0F172A),
                descriptionColor: const Color(0xFF334155),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bullet(
                      'Stack + Positioned: independent absolute placement; '
                      'children do not influence each other.',
                    ),
                    _bullet(
                      'CustomMultiChildLayout: named slots, inter-child '
                      'coordination, optional intrinsic sizing.',
                    ),
                    _bullet(
                      'Flow: fast custom painting-style transforms applied '
                      'each frame (no relayout); great for animations.',
                    ),
                    _bullet(
                      'Wrap: flow layout for runs of children that wrap to '
                      'new lines - no per-child positioning logic.',
                    ),
                  ],
                ),
              ),

              // -------------------------------------------------------------
              // SECTION 13: REFERENCE TABLE
              // -------------------------------------------------------------
              _section(
                title: '13. Delegate Reference',
                description: 'Subclasses defined in this script and their '
                    'LayoutId slots.',
                background: const Color(0xFFFAFAF9),
                titleColor: const Color(0xFF1C1917),
                descriptionColor: const Color(0xFF44403C),
                child: Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  border: TableBorder.all(
                    color: const Color(0xFFD6D3D1),
                    width: 1,
                  ),
                  children: const [
                    TableRow(
                      decoration: BoxDecoration(color: Color(0xFFE7E5E4)),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Delegate',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Child IDs',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_DashboardLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('header / sidebar / main / footer'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_ChatBubbleLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('avatar / content / timestamp / tail'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_PuzzleSolverLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('board / piece-1..4'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_PostcardLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('image / stamp / address / postmark'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_ResponsiveSplitLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('left / divider / right'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_NamedSlotCardLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('card-title / body / meta / button'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('_BezelLayoutDelegate'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('frame-tl/tr/bl/br + bezel-content'),
                      ),
                    ]),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _puzzlePiece(String label, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 24,
      ),
    ),
  );
}

Widget _corner(bool left, bool top) {
  return CustomPaint(
    painter: _CornerPainter(left: left, top: top),
    size: const Size(28, 28),
  );
}

class _CornerPainter extends CustomPainter {
  _CornerPainter({required this.left, required this.top});

  final bool left;
  final bool top;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF166534)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final double x0 = left ? 0 : size.width;
    final double y0 = top ? 0 : size.height;
    final double xMid = size.width / 2;
    final double yMid = size.height / 2;
    canvas.drawLine(
      Offset(x0, yMid),
      Offset(left ? xMid : xMid, yMid),
      paint,
    );
    canvas.drawLine(
      Offset(xMid, y0),
      Offset(xMid, yMid),
      paint,
    );
    canvas.drawLine(
      Offset(x0, yMid),
      Offset(xMid, yMid),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CornerPainter oldDelegate) =>
      oldDelegate.left != left || oldDelegate.top != top;
}
