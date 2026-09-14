// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  CONTEXT MENU CONTROLLER  --  A Rookery Olive Field Guide
// =============================================================================
//
//  Theme:        Rookery Olive
//  Subject:      package:flutter/widgets.dart
//                  ContextMenuController, ContextMenuButtonItem,
//                  ContextMenuButtonType, AdaptiveTextSelectionToolbar,
//                  BrowserContextMenu
//  Audience:     Ornithologists of the editing layer, observers of the rook
//                colonies that gather around selection toolbars at twilight,
//                and any developer who has wondered why the cut/copy/paste
//                menu looks so different on iOS, Android, macOS, and the
//                web -- and where in the framework that polymorphism is
//                actually negotiated.
//
//  Format:       One-shot Flutter widget tree. D4rt evaluates build() once.
//                There is no Stateful widget, no AnimationController, no
//                ContextMenuController.show() (which would require a real
//                runtime overlay). Instead the entire menu taxonomy is
//                rendered as static, hand-composed cards that mimic what
//                each platform's adaptive variant would produce.
//
// -----------------------------------------------------------------------------
//  Why a controller, and why a separate button-item type?
// -----------------------------------------------------------------------------
//  The selection toolbar in Flutter has a long evolutionary history. The
//  earliest toolbars were rigid -- one Material widget, one Cupertino
//  widget, the framework picked between them, and that was the end of the
//  conversation. Over many releases the toolbar split into three concerns:
//
//    * a *placement* concern   (TextSelectionToolbarAnchors),
//    * an *appearance* concern (the Material/Cupertino/Mac toolbar widgets),
//    * a *content* concern     (which buttons to show, in what order).
//
//  ContextMenuButtonItem is the value type that captures the *content*
//  concern. Each item is a small immutable record of:
//
//      * onPressed:  the callback that fires when the button is tapped,
//      * type:       a ContextMenuButtonType enum value -- one of cut,
//                    copy, paste, selectAll, delete, lookUp, searchWeb,
//                    share, liveTextInput, or custom,
//      * label:      an optional override label for custom items, or for
//                    cases where the platform-default label would be wrong.
//
//  ContextMenuController, in turn, is the *control surface* that lets you
//  show or hide a custom context menu programmatically. It is not used in
//  this snapshot -- show() requires a live overlay -- but the menu items
//  it would manage are exactly the same ContextMenuButtonItem values
//  rendered here.
//
//  AdaptiveTextSelectionToolbar.buttonItems is the bridge between content
//  and appearance: it takes anchors and a list of ContextMenuButtonItems,
//  inspects the host platform, and renders the appropriate platform
//  variant. On iOS it produces a CupertinoTextSelectionToolbar, on Android
//  a Material toolbar, on macOS a desktop-flavoured toolbar, on the web
//  a slimmer rendition. The buttonItems input is invariant across all
//  four platforms; only the appearance changes.
//
//  BrowserContextMenu, finally, is a tiny but critical web-only API. The
//  browser's *native* right-click menu would otherwise interfere with
//  Flutter's custom menu. BrowserContextMenu.disableContextMenu() asks
//  the browser to suppress its native menu so the Flutter menu can take
//  over. enableContextMenu() restores it. On non-web platforms these
//  calls are no-ops.
//
// -----------------------------------------------------------------------------
//  Public surface
// -----------------------------------------------------------------------------
//
//      class ContextMenuButtonItem {
//        const ContextMenuButtonItem({
//          required VoidCallback onPressed,
//          ContextMenuButtonType type = ContextMenuButtonType.custom,
//          String? label,
//        });
//        final VoidCallback onPressed;
//        final ContextMenuButtonType type;
//        final String? label;
//        ContextMenuButtonItem copyWith({...});
//      }
//
//      enum ContextMenuButtonType {
//        cut,
//        copy,
//        paste,
//        selectAll,
//        delete,
//        lookUp,
//        searchWeb,
//        share,
//        liveTextInput,
//        custom,
//      }
//
//      class ContextMenuController {
//        ContextMenuController({this.onRemove});
//        final VoidCallback? onRemove;
//        bool get isShown;
//        void show({required BuildContext context, required WidgetBuilder
//                   contextMenuBuilder, Widget? debugRequiredFor});
//        void markNeedsBuild();
//        void remove();
//        static void removeAny();
//      }
//
//      class AdaptiveTextSelectionToolbar extends StatelessWidget {
//        AdaptiveTextSelectionToolbar.buttonItems({
//          required TextSelectionToolbarAnchors anchors,
//          required List<ContextMenuButtonItem> buttonItems,
//        });
//        ...other named constructors omitted...
//      }
//
//      abstract class BrowserContextMenu {
//        static Future<void> disableContextMenu();
//        static Future<void> enableContextMenu();
//        static bool get enabled;
//      }
//
// -----------------------------------------------------------------------------
//  Rookery Olive palette
// -----------------------------------------------------------------------------
//    oliveCanopy      #6B7A2C   olive-green canopy where rooks roost
//    oliveDeep        #4A5320   shadowed olive trunk
//    oliveBright      #97A647   sunlit olive leaf, the highlight tone
//    rookCharcoal     #1F2024   the rook itself -- charcoal feathers
//    rookSlate        #383B41   feather edge, slightly lighter
//    rookBeak         #0E0E10   beak ink, the darkest accent
//    twilightIvory    #F0E9D2   parchment ivory of an evening sky
//    twilightSky      #BFB287   warmer twilight on the horizon
//    twilightDusk     #8C7E59   dusk before night
//    brassyAmber      #D69A2B   brassy amber for hover marks
//    brassyEmber      #8E6418   ember side of the amber
//    brassyGlow       #F2C36B   highlighted amber lacquer
//    coveMoss         #5C6F3E   hidden cove of the rookery
//    coveShadow       #2E3A20   deep shadow of the cove
//    quillInk         #2A2410   ornithologist's note ink
//    sealVerm         #A03A1F   wax seal accent
//    skyLavender      #7E7592   distant lavender twilight band
//
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Rookery Olive palette -- one declaration, used everywhere below.
// -----------------------------------------------------------------------------
const Color cOliveCanopy = Color(0xFF6B7A2C);
const Color cOliveDeep = Color(0xFF4A5320);
const Color cOliveBright = Color(0xFF97A647);
const Color cRookCharcoal = Color(0xFF1F2024);
const Color cRookSlate = Color(0xFF383B41);
const Color cRookBeak = Color(0xFF0E0E10);
const Color cTwilightIvory = Color(0xFFF0E9D2);
const Color cTwilightSky = Color(0xFFBFB287);
const Color cTwilightDusk = Color(0xFF8C7E59);
const Color cBrassyAmber = Color(0xFFD69A2B);
const Color cBrassyEmber = Color(0xFF8E6418);
const Color cBrassyGlow = Color(0xFFF2C36B);
const Color cCoveMoss = Color(0xFF5C6F3E);
const Color cCoveShadow = Color(0xFF2E3A20);
const Color cQuillInk = Color(0xFF2A2410);
const Color cSealVerm = Color(0xFFA03A1F);
const Color cSkyLavender = Color(0xFF7E7592);

// =============================================================================
//  build()
// =============================================================================
//  D4rt invokes this exactly once. Every ContextMenuButtonItem rendered
//  visually is constructed here using the real API. The .type, .label,
//  .onPressed properties of each item are read by the visual widgets that
//  follow. A real ContextMenuController is also instantiated (without
//  show() being called, since show() requires a live overlay).
// =============================================================================
dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // BUTTON ITEMS  --  one of every ContextMenuButtonType, plus a few
  // composite fixtures (custom labels, no-op handlers, repeated types).
  //
  // Every callback is intentionally a small closure that prints to the host
  // stdout. D4rt will never invoke them -- there is no real overlay tap
  // gesture -- but the items hold real VoidCallback references so the
  // value class is exercised in full.
  // ---------------------------------------------------------------------------

  final itemCut = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: cut'),
    type: ContextMenuButtonType.cut,
  );

  final itemCopy = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: copy'),
    type: ContextMenuButtonType.copy,
  );

  final itemPaste = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: paste'),
    type: ContextMenuButtonType.paste,
  );

  final itemSelectAll = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: selectAll'),
    type: ContextMenuButtonType.selectAll,
  );

  final itemDelete = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: delete'),
    type: ContextMenuButtonType.delete,
  );

  final itemLookUp = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: lookUp'),
    type: ContextMenuButtonType.lookUp,
  );

  final itemSearchWeb = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: searchWeb'),
    type: ContextMenuButtonType.searchWeb,
  );

  final itemShare = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: share'),
    type: ContextMenuButtonType.share,
  );

  final itemLiveTextInput = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: liveTextInput'),
    type: ContextMenuButtonType.liveTextInput,
  );

  final itemCustomTranslate = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: translate'),
    type: ContextMenuButtonType.custom,
    label: 'Translate',
  );

  final itemCustomBookmark = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: bookmark'),
    type: ContextMenuButtonType.custom,
    label: 'Bookmark',
  );

  final itemCustomReport = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: report'),
    type: ContextMenuButtonType.custom,
    label: 'Report',
  );

  // A label override for a typed item -- legal: type=copy, label='Duplicate'.
  final itemCopyAsDuplicate = ContextMenuButtonItem(
    onPressed: () => print('[Rookery Olive] tap: copy-as-duplicate'),
    type: ContextMenuButtonType.copy,
    label: 'Duplicate',
  );

  // A copyWith demonstration -- starts from itemCustomTranslate, swaps label.
  final itemCustomFromCopyWith = itemCustomTranslate.copyWith(
    label: 'Translate to French',
  );

  // ---------------------------------------------------------------------------
  // CONTROLLER  --  not shown, but instantiated so the value's runtimeType
  // and isShown property are exercised.
  // ---------------------------------------------------------------------------
  final controllerSilent = ContextMenuController(
    onRemove: () => print('[Rookery Olive] menu removed'),
  );

  // ---------------------------------------------------------------------------
  // ANCHORS  --  every AdaptiveTextSelectionToolbar.buttonItems requires a
  // TextSelectionToolbarAnchors. We construct three of them: a typical
  // word-selection, a top-clamped selection, and a caret-only.
  // ---------------------------------------------------------------------------
  final anchorMidWord = const TextSelectionToolbarAnchors(
    primaryAnchor: Offset(160, 220),
    secondaryAnchor: Offset(160, 252),
  );
  final anchorTopClamp = const TextSelectionToolbarAnchors(
    primaryAnchor: Offset(140, 60),
    secondaryAnchor: Offset(140, 92),
  );
  final anchorCaret = const TextSelectionToolbarAnchors(
    primaryAnchor: Offset(96, 140),
    secondaryAnchor: Offset(96, 140),
  );

  // ---------------------------------------------------------------------------
  // ADAPTIVE TOOLBARS  --  three real instances, each constructed via
  // AdaptiveTextSelectionToolbar.buttonItems with different button-item
  // populations. We do not insert these into the widget tree (D4rt cannot
  // render them without a live overlay) but their construction exercises
  // the constructor signature and confirms the buttonItems list is accepted.
  // ---------------------------------------------------------------------------
  final adaptiveToolbarA = AdaptiveTextSelectionToolbar.buttonItems(
    anchors: anchorMidWord,
    buttonItems: <ContextMenuButtonItem>[
      itemCut,
      itemCopy,
      itemPaste,
      itemSelectAll,
    ],
  );

  final adaptiveToolbarB = AdaptiveTextSelectionToolbar.buttonItems(
    anchors: anchorTopClamp,
    buttonItems: <ContextMenuButtonItem>[
      itemCopy,
      itemPaste,
      itemLookUp,
      itemSearchWeb,
      itemShare,
    ],
  );

  final adaptiveToolbarC = AdaptiveTextSelectionToolbar.buttonItems(
    anchors: anchorCaret,
    buttonItems: <ContextMenuButtonItem>[
      itemPaste,
      itemSelectAll,
      itemLiveTextInput,
      itemCustomTranslate,
    ],
  );

  // ---------------------------------------------------------------------------
  // Narrative print() trace -- these go to the host stdout when D4rt
  // evaluates this build() pass.
  // ---------------------------------------------------------------------------
  print('[Rookery Olive] === ContextMenuController field guide ===');
  print('[Rookery Olive] ContextMenuButtonType has '
      '${ContextMenuButtonType.values.length} cases.');
  print('[Rookery Olive] itemCut.type = ${itemCut.type}, label = ${itemCut.label}');
  print('[Rookery Olive] itemCopy.type = ${itemCopy.type}');
  print('[Rookery Olive] itemPaste.type = ${itemPaste.type}');
  print('[Rookery Olive] itemSelectAll.type = ${itemSelectAll.type}');
  print('[Rookery Olive] itemDelete.type = ${itemDelete.type}');
  print('[Rookery Olive] itemLookUp.type = ${itemLookUp.type}');
  print('[Rookery Olive] itemSearchWeb.type = ${itemSearchWeb.type}');
  print('[Rookery Olive] itemShare.type = ${itemShare.type}');
  print('[Rookery Olive] itemLiveTextInput.type = ${itemLiveTextInput.type}');
  print('[Rookery Olive] itemCustomTranslate.type = '
      '${itemCustomTranslate.type}, label = ${itemCustomTranslate.label}');
  print('[Rookery Olive] itemCustomBookmark.label = ${itemCustomBookmark.label}');
  print('[Rookery Olive] itemCustomReport.label = ${itemCustomReport.label}');
  print('[Rookery Olive] itemCopyAsDuplicate -- type ${itemCopyAsDuplicate.type} '
      'with override label ${itemCopyAsDuplicate.label}');
  print('[Rookery Olive] itemCustomFromCopyWith.label = '
      '${itemCustomFromCopyWith.label}');
  print('[Rookery Olive] controllerSilent.isShown = ${controllerSilent.isShown}');
  print('[Rookery Olive] controllerSilent.runtimeType = '
      '${controllerSilent.runtimeType}');
  print('[Rookery Olive] adaptiveToolbarA.runtimeType = '
      '${adaptiveToolbarA.runtimeType}');
  print('[Rookery Olive] adaptiveToolbarB.runtimeType = '
      '${adaptiveToolbarB.runtimeType}');
  print('[Rookery Olive] adaptiveToolbarC.runtimeType = '
      '${adaptiveToolbarC.runtimeType}');
  print('[Rookery Olive] Building 14 rookery cards...');
  print('[Rookery Olive] === build() exiting normally ===');

  // ---------------------------------------------------------------------------
  // Compose the full visual tree. Fourteen rookery cards inside a single
  // SingleChildScrollView. Each card is a roost in the olive canopy.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: cTwilightIvory,
    appBar: AppBar(
      backgroundColor: cOliveDeep,
      foregroundColor: cBrassyGlow,
      elevation: 0,
      title: const Text(
        'ContextMenuController -- Rookery Olive Field Guide',
        style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.4),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------------
          // SECTION 1 -- Title banner with palette swatches.
          // -------------------------------------------------------------------
          _buildSection1Banner(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 2 -- Anatomy of a ContextMenuButtonItem.
          // -------------------------------------------------------------------
          _buildSection2Anatomy(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 3 -- ContextMenuButtonType enum tour.
          // -------------------------------------------------------------------
          _buildSection3EnumTour(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 4 -- Property table for ContextMenuButtonItem.
          // -------------------------------------------------------------------
          _buildSection4Properties(itemCut, itemCustomTranslate),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 5 -- ContextMenuController surface.
          // -------------------------------------------------------------------
          _buildSection5Controller(controllerSilent),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 6 -- Platform-aware menu compositions (Android Material).
          // -------------------------------------------------------------------
          _buildSection6Android(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 7 -- Platform-aware menu compositions (iOS Cupertino).
          // -------------------------------------------------------------------
          _buildSection7IOS(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 8 -- Platform-aware menu compositions (macOS desktop).
          // -------------------------------------------------------------------
          _buildSection8MacOS(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 9 -- Platform-aware menu compositions (Web).
          // -------------------------------------------------------------------
          _buildSection9Web(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 10 -- Button-item factory patterns.
          // -------------------------------------------------------------------
          _buildSection10FactoryPatterns(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 11 -- AdaptiveTextSelectionToolbar layout walkthrough.
          // -------------------------------------------------------------------
          _buildSection11AdaptiveLayout(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 12 -- BrowserContextMenu disable/restore semantics.
          // -------------------------------------------------------------------
          _buildSection12BrowserContextMenu(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 13 -- DO / AVOID callouts.
          // -------------------------------------------------------------------
          _buildSection13DoAvoid(),
          const SizedBox(height: 24),

          // -------------------------------------------------------------------
          // SECTION 14 -- Recipes & glossary footer.
          // -------------------------------------------------------------------
          _buildSection14Recipes(),
          const SizedBox(height: 64),
        ],
      ),
    ),
  );
}

// =============================================================================
//  SECTION 1 -- Title banner with palette swatches.
// =============================================================================
//  An olive canopy at twilight. Brassy-amber lacquer trim. The title is
//  hand-lettered as if scrawled in an ornithologist's field notebook.
// =============================================================================
Widget _buildSection1Banner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cOliveDeep, cOliveCanopy, cCoveMoss],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: cBrassyAmber, width: 2),
      boxShadow: [
        BoxShadow(
          color: cRookBeak.withValues(alpha: 0.22),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ContextMenuController',
          style: TextStyle(
            color: cBrassyGlow,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'a rookery at twilight, hidden coves of options,',
          style: TextStyle(
            color: cTwilightIvory,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        const Text(
          'every platform a different roost on the same olive branch',
          style: TextStyle(
            color: cTwilightIvory,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Rookery Olive Field Guide -- package:flutter/widgets.dart',
          style: TextStyle(color: cTwilightSky, fontSize: 11),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _swatch('canopy', cOliveCanopy),
            _swatch('deep', cOliveDeep),
            _swatch('bright', cOliveBright),
            _swatch('rook', cRookCharcoal),
            _swatch('slate', cRookSlate),
            _swatch('beak', cRookBeak),
            _swatch('ivory', cTwilightIvory),
            _swatch('sky', cTwilightSky),
            _swatch('dusk', cTwilightDusk),
            _swatch('amber', cBrassyAmber),
            _swatch('ember', cBrassyEmber),
            _swatch('glow', cBrassyGlow),
            _swatch('moss', cCoveMoss),
            _swatch('cove', cCoveShadow),
            _swatch('quill', cQuillInk),
            _swatch('seal', cSealVerm),
            _swatch('lavender', cSkyLavender),
          ],
        ),
      ],
    ),
  );
}

Widget _swatch(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: Column(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: cTwilightIvory.withValues(alpha: 0.6)),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: cTwilightIvory, fontSize: 9),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 2 -- Anatomy of a ContextMenuButtonItem.
// =============================================================================
//  Several paragraphs of prose, hand-lettered in quill-ink umber, that
//  explain the role of each field in the value type.
// =============================================================================
Widget _buildSection2Anatomy() {
  return _sectionCard(
    title: '2 -- Anatomy of a ContextMenuButtonItem',
    accent: cOliveDeep,
    children: const [
      Text(
        'A context menu, observed from outside, is a small floating panel '
        'with a row or column of labelled buttons. Observed from inside, '
        'it is a list of value records -- one per button -- that the '
        'platform-specific toolbar widget consumes and renders. '
        'ContextMenuButtonItem is that record.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cQuillInk),
      ),
      SizedBox(height: 10),
      Text(
        'The onPressed callback is mandatory. It is what runs when the user '
        'taps the button. The framework wraps the call so that the toolbar '
        'auto-dismisses after a tap -- you do not need to call '
        'ContextMenuController.removeAny() yourself in the onPressed body.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cQuillInk),
      ),
      SizedBox(height: 10),
      Text(
        'The type field is a ContextMenuButtonType enum value. It tells '
        'the platform-specific toolbar what kind of button this is, so the '
        'toolbar can apply the correct platform-default label, ordering, '
        'and platform-default icon (on those platforms that show icons). '
        'ContextMenuButtonType.custom means "do not apply a default label '
        '-- use the label field verbatim".',
        style: TextStyle(fontSize: 13, height: 1.55, color: cQuillInk),
      ),
      SizedBox(height: 10),
      Text(
        'The label field is optional. For typed items (cut, copy, paste...) '
        'leaving it null lets the platform supply the localised label '
        '("Coller" on a French iOS device, "Paste" on English Android, '
        '"Einfugen" on a German Cupertino toolbar). For custom items the '
        'label is required -- the framework has no localised default for '
        '"Bookmark" or "Translate", so you must supply one. You may also '
        'supply a label for a typed item if you want to override the '
        'platform default; this is rare and usually a smell.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cQuillInk),
      ),
      SizedBox(height: 10),
      Text(
        'ContextMenuButtonItem is intentionally tiny. It holds no widget, '
        'no icon, no styling -- just a callback, a type, and an optional '
        'string. The platform-specific toolbar widgets are responsible for '
        'turning each item into the visual button their host platform '
        'expects. This is what lets the same buttonItems list render '
        'completely different on Android (Material chips), iOS (rounded '
        'pill buttons), macOS (a vertical menu strip), and Web (a slim '
        'flat row).',
        style: TextStyle(fontSize: 13, height: 1.55, color: cQuillInk),
      ),
      SizedBox(height: 10),
      Text(
        'The class also exposes a copyWith method so you can derive a new '
        'item from an existing one, swapping just the fields you care '
        'about. This pairs well with a "default toolbar" pattern: take the '
        'platform-default buttonItems from the EditableTextState, then map '
        'over them with copyWith to insert a custom onPressed for, say, '
        'the paste button.',
        style: TextStyle(fontSize: 13, height: 1.55, color: cQuillInk),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 3 -- ContextMenuButtonType enum tour.
// =============================================================================
//  A horizontal grid of small cards, one per enum case, each with the case
//  name, its typical platform-default label, and a one-sentence description.
//  This is the canonical "what does each type mean" reference.
// =============================================================================
Widget _buildSection3EnumTour() {
  return _sectionCard(
    title: '3 -- ContextMenuButtonType Enum Tour',
    accent: cOliveBright,
    children: [
      const Text(
        'Ten cases, ten roles. The framework maps each case to a localised '
        'string and a platform-appropriate icon. The custom case is the '
        'escape hatch for anything that does not fit the predefined roles.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _enumRow('cut', 'Cut',
          'Remove the selected text and place it on the clipboard.'),
      _enumRow('copy', 'Copy',
          'Place the selected text on the clipboard without removing it.'),
      _enumRow('paste', 'Paste',
          'Insert the clipboard contents at the caret position.'),
      _enumRow('selectAll', 'Select All',
          'Extend the selection to cover the entire editable region.'),
      _enumRow('delete', 'Delete',
          'Remove the selected text without placing it on the clipboard.'),
      _enumRow('lookUp', 'Look Up',
          'Open the platform dictionary on the selected term (iOS, macOS).'),
      _enumRow('searchWeb', 'Search Web',
          'Hand the selection to the platform web search affordance.'),
      _enumRow('share', 'Share',
          'Open the platform share sheet with the selected text.'),
      _enumRow('liveTextInput', 'Live Text Input',
          'Trigger camera-based live text capture (iOS only, ignored elsewhere).'),
      _enumRow('custom', '<your label>',
          'Application-specific item; supply the label yourself.'),
    ],
  );
}

Widget _enumRow(String name, String label, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            'ContextMenuButtonType.$name',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: cOliveDeep,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              color: cBrassyEmber,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: cQuillInk),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 4 -- Property table for ContextMenuButtonItem.
// =============================================================================
//  Live values from itemCut and itemCustomTranslate, side by side.
// =============================================================================
Widget _buildSection4Properties(
    ContextMenuButtonItem typed, ContextMenuButtonItem custom) {
  return _sectionCard(
    title: '4 -- Property Anatomy of ContextMenuButtonItem',
    accent: cCoveMoss,
    children: [
      _propRow('onPressed', 'VoidCallback',
          'Required. Runs when the user taps the button. The toolbar auto-dismisses afterwards.'),
      _propRow('type', 'ContextMenuButtonType',
          'Defaults to custom. Determines the platform-default label and icon.'),
      _propRow('label', 'String?',
          'Optional override. Required for custom; rare on typed items.'),
      _propRow('copyWith({...})', 'method',
          'Returns a new item with selected fields replaced; original is untouched.'),
      _propRow('==, hashCode', 'value semantics',
          'Compared by type + label; the callback is intentionally excluded.'),
      const SizedBox(height: 12),
      const Text(
        'Live values from itemCut (typed):',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cQuillInk, fontSize: 12),
      ),
      _propRow('typed.type', 'ContextMenuButtonType', '${typed.type}'),
      _propRow('typed.label', 'String?',
          typed.label == null ? '<null -- platform default>' : typed.label!),
      _propRow('typed.runtimeType', 'Type', '${typed.runtimeType}'),
      const SizedBox(height: 8),
      const Text(
        'Live values from itemCustomTranslate (custom + label):',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cQuillInk, fontSize: 12),
      ),
      _propRow('custom.type', 'ContextMenuButtonType', '${custom.type}'),
      _propRow('custom.label', 'String?',
          custom.label == null ? '<null>' : custom.label!),
      _propRow('custom.runtimeType', 'Type', '${custom.runtimeType}'),
    ],
  );
}

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: cOliveDeep,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: cSkyLavender,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 12, color: cQuillInk),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 5 -- ContextMenuController surface.
// =============================================================================
//  An explanation of the controller class, including isShown, show(),
//  remove(), and removeAny(). Live property reads on a real instance.
// =============================================================================
Widget _buildSection5Controller(ContextMenuController c) {
  return _sectionCard(
    title: '5 -- ContextMenuController Surface',
    accent: cBrassyEmber,
    children: [
      const Text(
        'ContextMenuController is the imperative surface for the context '
        'menu system. It is *not* a widget. It is a small object you '
        'instantiate, hold onto, and call show()/remove() on. The framework '
        'tracks at most one shown controller at a time -- showing a new '
        'controller automatically removes any previously shown one.',
        style: TextStyle(fontSize: 13, height: 1.5, color: cQuillInk),
      ),
      const SizedBox(height: 10),
      const Text(
        'Three methods you will use often:',
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: cOliveDeep),
      ),
      const SizedBox(height: 4),
      _bulletProse(
          'show(context, contextMenuBuilder)',
          'Inserts an OverlayEntry at the top of the current Overlay. '
              'The builder receives a BuildContext and returns the menu '
              'widget. Re-rendering happens automatically when the host '
              'tree rebuilds.'),
      _bulletProse(
          'remove()',
          'Removes the overlay entry created by this controller. '
              'Called automatically when the user taps a button, taps '
              'outside the menu, or scrolls a containing scrollable.'),
      _bulletProse(
          'removeAny() (static)',
          'Removes whichever controller is currently shown system-wide. '
              'Useful when you want to dismiss the menu from far away in '
              'the widget tree without holding the controller reference.'),
      _bulletProse(
          'markNeedsBuild()',
          'Asks the overlay entry to rebuild. Use after mutating state '
              'that the contextMenuBuilder closes over.'),
      _bulletProse(
          'onRemove (constructor parameter)',
          'Optional callback fired when the controller is removed. Use it '
              'to clear local "menu visible" state in your widget.'),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cTwilightIvory,
          border: Border.all(color: cOliveCanopy.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Live values from controllerSilent:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: cQuillInk),
            ),
            const SizedBox(height: 6),
            Text('isShown: ${c.isShown}',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: cBrassyEmber)),
            Text('runtimeType: ${c.runtimeType}',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: cBrassyEmber)),
            Text('onRemove: ${c.onRemove == null ? "<null>" : "<closure>"}',
                style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: cBrassyEmber)),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        'Note: this snapshot does *not* call show(). show() requires an '
        'attached Overlay and a real-time scheduler binding -- neither of '
        'which is available in a single static D4rt evaluation. Use the '
        'controller in a Stateful widget where initState/dispose can '
        'manage its lifecycle.',
        style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: cTwilightDusk),
      ),
    ],
  );
}

Widget _bulletProse(String head, String body) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('  -  ',
            style: TextStyle(
                color: cBrassyAmber,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12, color: cQuillInk, height: 1.45),
              children: [
                TextSpan(
                    text: '$head  ',
                    style: const TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: cOliveDeep)),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 6 -- Android Material context menu compositions.
// =============================================================================
//  Android's context menu is the Material variant: a horizontal pill of
//  buttons with a small overflow caret if the items do not all fit.
//  Background is the Material surface tone; labels are short, dense,
//  capitalised in title case. We render four mock toolbars covering
//  the most common item populations.
// =============================================================================
Widget _buildSection6Android() {
  return _sectionCard(
    title: '6 -- Android Material Composition',
    accent: cOliveCanopy,
    children: [
      const Text(
        'On Android, AdaptiveTextSelectionToolbar produces a Material '
        'TextSelectionToolbar -- a thin horizontal bar with the buttons '
        'rendered as Material text-only pills. Labels are platform-default '
        'localised strings ("Cut", "Copy", "Paste", "Select all"). Items '
        'beyond a fixed visible count collapse into an overflow menu reached '
        'via a vertical-dots affordance.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _platformLabel('Mock 1: simple cut/copy/paste/selectAll'),
      _androidToolbar(const <_AndroidPill>[
        _AndroidPill('Cut'),
        _AndroidPill('Copy'),
        _AndroidPill('Paste'),
        _AndroidPill('Select all'),
      ]),
      const SizedBox(height: 12),
      _platformLabel('Mock 2: with lookUp + share'),
      _androidToolbar(const <_AndroidPill>[
        _AndroidPill('Copy'),
        _AndroidPill('Paste'),
        _AndroidPill('Look up'),
        _AndroidPill('Share'),
      ]),
      const SizedBox(height: 12),
      _platformLabel('Mock 3: editable with delete + selectAll'),
      _androidToolbar(const <_AndroidPill>[
        _AndroidPill('Cut'),
        _AndroidPill('Copy'),
        _AndroidPill('Paste'),
        _AndroidPill('Delete'),
        _AndroidPill('Select all'),
      ]),
      const SizedBox(height: 12),
      _platformLabel('Mock 4: overflow caret (custom item beyond visible)'),
      _androidToolbar(const <_AndroidPill>[
        _AndroidPill('Copy'),
        _AndroidPill('Paste'),
        _AndroidPill('Translate'),
        _AndroidPill('Bookmark', overflow: true),
      ]),
      const SizedBox(height: 12),
      const Text(
        'Notes for Android:\n'
        '  - The Material toolbar is rectangular with a 4dp corner radius.\n'
        '  - Background uses the surface tone of the active ColorScheme.\n'
        '  - Labels are sentence-case with the first word capitalised.\n'
        '  - The first overflow target is "Select all" if more than four '
        'visible items are requested; the framework counts dynamically.',
        style: TextStyle(fontSize: 11, color: cTwilightDusk, height: 1.45),
      ),
    ],
  );
}

class _AndroidPill {
  final String label;
  final bool overflow;
  const _AndroidPill(this.label, {this.overflow = false});
}

Widget _androidToolbar(List<_AndroidPill> pills) {
  // Use indexed iteration -- never for-in.
  final children = <Widget>[];
  for (int i = 0; i < pills.length; i++) {
    final p = pills[i];
    if (p.overflow) {
      children.add(_androidOverflowCaret());
    } else {
      children.add(_androidPillWidget(p.label));
    }
    if (i < pills.length - 1) {
      children.add(const SizedBox(width: 2));
    }
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: cRookSlate.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: cRookBeak.withValues(alpha: 0.18),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget _androidPillWidget(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(2),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFF1B5E20),
        fontWeight: FontWeight.w600,
        fontSize: 13,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _androidOverflowCaret() {
  return Container(
    width: 28,
    height: 32,
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF1B5E20), shape: BoxShape.circle)),
        const SizedBox(height: 2),
        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF1B5E20), shape: BoxShape.circle)),
        const SizedBox(height: 2),
        Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF1B5E20), shape: BoxShape.circle)),
      ],
    ),
  );
}

Widget _platformLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 2),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        color: cBrassyEmber,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// =============================================================================
//  SECTION 7 -- iOS Cupertino context menu compositions.
// =============================================================================
//  The Cupertino variant is visually distinct: a dark, rounded pill bar
//  with an arrow tail pointing at the selection, light text on a near-black
//  background, vertical separators between buttons, and a chevron arrow if
//  there are more pages of items.
// =============================================================================
Widget _buildSection7IOS() {
  return _sectionCard(
    title: '7 -- iOS Cupertino Composition',
    accent: cRookCharcoal,
    children: [
      const Text(
        'iOS uses CupertinoTextSelectionToolbar -- a dark capsule with a '
        'pointing tail. The tail flips above/below the selection based on '
        'available room (this is where the secondaryAnchor matters). '
        'Labels are localised, the icon set is platform-specific, and a '
        'chevron arrow appears at the trailing edge when items overflow. '
        'iOS uniquely supports liveTextInput, lookUp, share, and a '
        'platform-localised "Replace..." flow on long-press.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _platformLabel('Mock 5: cut / copy / paste / select all'),
      _iosToolbar(const <String>['Cut', 'Copy', 'Paste', 'Select All']),
      const SizedBox(height: 12),
      _platformLabel('Mock 6: with Look Up + Share'),
      _iosToolbar(const <String>['Copy', 'Look Up', 'Translate', 'Share']),
      const SizedBox(height: 12),
      _platformLabel('Mock 7: with Live Text input (camera)'),
      _iosToolbar(const <String>['Paste', 'Select All', 'Scan Text', 'Look Up']),
      const SizedBox(height: 12),
      _platformLabel('Mock 8: chevron overflow at trailing edge'),
      _iosToolbar(
        const <String>['Cut', 'Copy', 'Paste', 'Select All'],
        chevron: true,
      ),
      const SizedBox(height: 12),
      const Text(
        'Notes for iOS:\n'
        '  - Background is system label colour with reduced alpha.\n'
        '  - Buttons are separated by hairline vertical dividers.\n'
        '  - Live Text Input renders only when the device camera and OS '
        'support it -- otherwise the type is silently dropped.\n'
        '  - The toolbar inverts colours under reduce-transparency.',
        style: TextStyle(fontSize: 11, color: cTwilightDusk, height: 1.45),
      ),
    ],
  );
}

Widget _iosToolbar(List<String> labels, {bool chevron = false}) {
  final children = <Widget>[];
  for (int i = 0; i < labels.length; i++) {
    children.add(_iosButton(labels[i]));
    if (i < labels.length - 1) {
      children.add(_iosDivider());
    }
  }
  if (chevron) {
    children.add(_iosDivider());
    children.add(_iosChevron());
  }
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 14),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration: BoxDecoration(
          color: cRookCharcoal,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: cRookBeak.withValues(alpha: 0.40),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      Positioned(
        bottom: 6,
        left: 38,
        child: CustomPaint(
          size: const Size(12, 8),
          painter: _IosTailPainter(),
        ),
      ),
    ],
  );
}

Widget _iosButton(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFEFEFF4),
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget _iosDivider() {
  return Container(
    width: 1,
    height: 22,
    color: cRookSlate,
    margin: const EdgeInsets.symmetric(vertical: 6),
  );
}

Widget _iosChevron() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Text(
      '>',
      style: TextStyle(
        color: Color(0xFFEFEFF4),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    ),
  );
}

class _IosTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = cRookCharcoal;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
//  SECTION 8 -- macOS desktop context menu compositions.
// =============================================================================
//  Desktop right-click invokes a tall, vertical menu strip with one item per
//  row. Labels are localised, keyboard shortcuts appear in the trailing
//  column, and section dividers separate logical groups (cut/copy/paste,
//  selection ops, lookup ops, custom ops).
// =============================================================================
Widget _buildSection8MacOS() {
  return _sectionCard(
    title: '8 -- macOS Desktop Composition',
    accent: cSkyLavender,
    children: [
      const Text(
        'On macOS the toolbar is no longer a horizontal pill -- it is a '
        'vertical menu, more in line with desktop platform conventions. '
        'Each row is a single item, with a leading visible label and a '
        'trailing keyboard shortcut hint. Section dividers split the menu '
        'into logical groups: editing operations, selection operations, '
        'lookup operations, custom operations.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _platformLabel('Mock 9: full clipboard menu'),
      _macMenu(const <_MacRow>[
        _MacRow('Cut', 'Cmd+X'),
        _MacRow('Copy', 'Cmd+C'),
        _MacRow('Paste', 'Cmd+V'),
        _MacRow.divider(),
        _MacRow('Select All', 'Cmd+A'),
      ]),
      const SizedBox(height: 12),
      _platformLabel('Mock 10: with lookup + custom items'),
      _macMenu(const <_MacRow>[
        _MacRow('Copy', 'Cmd+C'),
        _MacRow('Paste', 'Cmd+V'),
        _MacRow.divider(),
        _MacRow('Look Up', ''),
        _MacRow('Search Web', ''),
        _MacRow.divider(),
        _MacRow('Translate', ''),
        _MacRow('Bookmark', ''),
      ]),
      const SizedBox(height: 12),
      const Text(
        'Notes for macOS:\n'
        '  - The vertical layout matches NSMenu, the Cocoa equivalent.\n'
        '  - Keyboard shortcut hints are right-aligned in a monospace font.\n'
        '  - Dividers are 1px hairlines in tertiary label colour.\n'
        '  - Hover state uses the systemHighlightColor with reduced alpha.',
        style: TextStyle(fontSize: 11, color: cTwilightDusk, height: 1.45),
      ),
    ],
  );
}

class _MacRow {
  final String label;
  final String shortcut;
  final bool isDivider;
  const _MacRow(this.label, this.shortcut) : isDivider = false;
  const _MacRow.divider()
      : label = '',
        shortcut = '',
        isDivider = true;
}

Widget _macMenu(List<_MacRow> rows) {
  final children = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final r = rows[i];
    if (r.isDivider) {
      children.add(Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        color: cRookSlate.withValues(alpha: 0.25),
      ));
    } else {
      children.add(_macMenuRow(r));
    }
  }
  return Container(
    width: 220,
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFFF6F4F1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cRookSlate.withValues(alpha: 0.30)),
      boxShadow: [
        BoxShadow(
          color: cRookBeak.withValues(alpha: 0.20),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget _macMenuRow(_MacRow r) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      children: [
        Expanded(
          child: Text(
            r.label,
            style: const TextStyle(
                color: Color(0xFF1A1A1A), fontSize: 12),
          ),
        ),
        Text(
          r.shortcut,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF7A7A7A),
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 9 -- Web context menu compositions.
// =============================================================================
//  On the web, the AdaptiveTextSelectionToolbar produces a slim, flat
//  variant that does not try to compete with the browser's native styling.
//  Importantly, BrowserContextMenu must be disabled first or the browser's
//  native menu shows on right-click instead.
// =============================================================================
Widget _buildSection9Web() {
  return _sectionCard(
    title: '9 -- Web Composition (with BrowserContextMenu)',
    accent: cBrassyAmber,
    children: [
      const Text(
        'On Flutter web, the toolbar is a thin horizontal bar with flat '
        'buttons. The browser, however, has its own right-click context '
        'menu that will appear on top of (or instead of) the Flutter menu '
        'unless explicitly suppressed. BrowserContextMenu.disableContextMenu '
        'tells the embedding HTML to swallow oncontextmenu events; '
        'enableContextMenu restores the default behaviour.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _platformLabel('Mock 11: web flat toolbar'),
      _webToolbar(const <String>['Cut', 'Copy', 'Paste', 'Select all']),
      const SizedBox(height: 12),
      _platformLabel('Mock 12: web with custom items'),
      _webToolbar(const <String>[
        'Copy',
        'Paste',
        'Search web',
        'Translate',
        'Bookmark',
      ]),
      const SizedBox(height: 12),
      const Text(
        'Notes for web:\n'
        '  - Without BrowserContextMenu.disableContextMenu, the browser\'s '
        'native right-click menu fires *first* and the Flutter menu never '
        'appears.\n'
        '  - The web toolbar visual is intentionally minimal; it inherits '
        'the host font.\n'
        '  - The disable/enable pair should be paired with matching '
        'lifecycle events: disable in initState, enable in dispose.',
        style: TextStyle(fontSize: 11, color: cTwilightDusk, height: 1.45),
      ),
    ],
  );
}

Widget _webToolbar(List<String> labels) {
  final children = <Widget>[];
  for (int i = 0; i < labels.length; i++) {
    children.add(_webButton(labels[i]));
    if (i < labels.length - 1) {
      children.add(const SizedBox(width: 4));
    }
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: cTwilightIvory,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: cRookSlate.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: cRookBeak.withValues(alpha: 0.16),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget _webButton(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: cTwilightIvory,
      borderRadius: BorderRadius.circular(2),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: cQuillInk,
        fontSize: 12,
      ),
    ),
  );
}

// =============================================================================
//  SECTION 10 -- Button-item factory patterns.
// =============================================================================
//  Three idiomatic patterns for producing a List<ContextMenuButtonItem>.
//  These are not framework APIs -- they are conventions developers adopt
//  when assembling toolbars that vary by mode (read-only / editable /
//  password / hidden-paste).
// =============================================================================
Widget _buildSection10FactoryPatterns() {
  return _sectionCard(
    title: '10 -- Factory Patterns for buttonItems',
    accent: cCoveShadow,
    children: [
      const Text(
        'Three patterns recur when assembling a buttonItems list. None of '
        'them are framework APIs -- they are developer-side conventions '
        'that simplify common cases.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _patternBlock(
        'Pattern A -- Default + extend',
        'Take EditableTextState.contextMenuButtonItems and append your '
            'custom items at the trailing edge. The platform-default cut/'
            'copy/paste/select-all/look-up come for free.',
        const <String>[
          'final items = [',
          '  ...editableState.contextMenuButtonItems,',
          '  ContextMenuButtonItem(',
          '    onPressed: handleTranslate,',
          '    type: ContextMenuButtonType.custom,',
          '    label: "Translate",',
          '  ),',
          '];',
        ],
      ),
      _patternBlock(
        'Pattern B -- Filter + replace',
        'Iterate the platform-default items, drop any whose type matches '
            'a deny-list, and replace handlers via copyWith. Useful when '
            'you want to intercept the paste handler without losing the '
            'localised label.',
        const <String>[
          'final filtered = <ContextMenuButtonItem>[];',
          'final defaults = editableState.contextMenuButtonItems;',
          'for (var i = 0; i < defaults.length; i++) {',
          '  final it = defaults[i];',
          '  if (it.type == ContextMenuButtonType.cut) continue;',
          '  if (it.type == ContextMenuButtonType.paste) {',
          '    filtered.add(it.copyWith(onPressed: secureHandlePaste));',
          '  } else {',
          '    filtered.add(it);',
          '  }',
          '}',
        ],
      ),
      _patternBlock(
        'Pattern C -- From scratch',
        'Build the entire list yourself. Useful when the editor is read-'
            'only or when none of the platform defaults make sense (a chat '
            'input that only allows copy + select-all + share, for '
            'example).',
        const <String>[
          'final items = <ContextMenuButtonItem>[',
          '  ContextMenuButtonItem(',
          '    onPressed: handleCopy,',
          '    type: ContextMenuButtonType.copy,',
          '  ),',
          '  ContextMenuButtonItem(',
          '    onPressed: handleSelectAll,',
          '    type: ContextMenuButtonType.selectAll,',
          '  ),',
          '  ContextMenuButtonItem(',
          '    onPressed: handleShare,',
          '    type: ContextMenuButtonType.share,',
          '  ),',
          '];',
        ],
      ),
      const SizedBox(height: 8),
      const Text(
        'Pattern A is the most common in production code -- it leaves the '
        'platform-default localisation work to the framework. Pattern B is '
        'the right shape when you need security overrides. Pattern C is '
        'reserved for cases where the editor is non-standard or the '
        'document model dictates the button population.',
        style: TextStyle(fontSize: 12, color: cQuillInk, height: 1.45),
      ),
    ],
  );
}

Widget _patternBlock(String title, String prose, List<String> code) {
  final codeChildren = <Widget>[];
  for (int i = 0; i < code.length; i++) {
    codeChildren.add(Text(
      code[i],
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: cBrassyEmber,
        height: 1.35,
      ),
    ));
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cTwilightIvory,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: cOliveCanopy.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: cOliveDeep,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          prose,
          style: const TextStyle(
              color: cQuillInk, fontSize: 12, height: 1.45),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cRookCharcoal,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: codeChildren,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 11 -- AdaptiveTextSelectionToolbar layout walkthrough.
// =============================================================================
//  How the adaptive variant decides which platform widget to instantiate.
//  Includes a small flow-chart-like diagram with arrows and labels.
// =============================================================================
Widget _buildSection11AdaptiveLayout() {
  return _sectionCard(
    title: '11 -- AdaptiveTextSelectionToolbar Layout Walkthrough',
    accent: cOliveBright,
    children: [
      const Text(
        'AdaptiveTextSelectionToolbar.buttonItems is a stateless widget '
        'that, at build time, inspects Theme.of(context).platform and picks '
        'one of four concrete subclasses to render:',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 12),
      _adaptiveFlow(),
      const SizedBox(height: 12),
      const Text(
        'The decision is made fresh on every rebuild. If the host theme\'s '
        'platform changes (e.g. via a developer toggle in DevTools), the '
        'toolbar re-renders with the new platform variant on the next '
        'frame. There is no caching of the chosen variant.',
        style: TextStyle(fontSize: 12, color: cQuillInk, height: 1.45),
      ),
      const SizedBox(height: 10),
      const Text(
        'The buttonItems input is mapped to platform-specific button '
        'widgets by each variant. The mapping is:',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 6),
      _bulletProse('Material (Android, fuchsia)',
          'Each item becomes a TextSelectionToolbarTextButton in a '
              'horizontal row. Overflow handled by an internal '
              '_TextSelectionToolbarOverflowable widget.'),
      _bulletProse('Cupertino (iOS)',
          'Each item becomes a CupertinoTextSelectionToolbarButton. The '
              'toolbar also draws an arrow tail pointing at the anchor.'),
      _bulletProse('Desktop (macOS, Linux, Windows)',
          'Each item becomes a row in a vertical menu. The desktop '
              'variant respects the system menu styling guidelines.'),
      _bulletProse('Web fallback',
          'When the platform value is web, the framework picks the '
              'closest matching desktop or mobile variant based on the '
              'Theme\'s platform field, which the embedder usually maps '
              'from navigator.userAgent.'),
    ],
  );
}

Widget _adaptiveFlow() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cTwilightIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cOliveCanopy.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Theme.of(context).platform',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: cOliveDeep,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          margin: const EdgeInsets.only(left: 12),
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _flowArrow('android, fuchsia',
                  'TextSelectionToolbar (Material)'),
              _flowArrow('iOS', 'CupertinoTextSelectionToolbar'),
              _flowArrow(
                  'macOS', 'CupertinoDesktopTextSelectionToolbar'),
              _flowArrow('linux, windows',
                  'DesktopTextSelectionToolbar (Material desktop)'),
              _flowArrow('(web overlay)',
                  'one of the above based on userAgent'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowArrow(String left, String right) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            left,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: cBrassyEmber,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Text(
          ' --->  ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: cTwilightDusk,
          ),
        ),
        Expanded(
          child: Text(
            right,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: cOliveDeep,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 12 -- BrowserContextMenu disable/restore semantics.
// =============================================================================
//  How and when to disable the browser's native context menu, including a
//  paired-lifecycle code example.
// =============================================================================
Widget _buildSection12BrowserContextMenu() {
  return _sectionCard(
    title: '12 -- BrowserContextMenu disable/restore',
    accent: cSealVerm,
    children: [
      const Text(
        'BrowserContextMenu is a static-only class with two lifecycle '
        'methods and one boolean property. It exists exclusively for '
        'Flutter web; on every other platform the methods complete '
        'immediately as no-ops.',
        style: TextStyle(fontSize: 12, color: cQuillInk),
      ),
      const SizedBox(height: 10),
      _propRow('disableContextMenu()', 'Future<void>',
          'Asks the host page to swallow oncontextmenu events. Returns a Future that resolves when the host has acknowledged.'),
      _propRow('enableContextMenu()', 'Future<void>',
          'Asks the host page to allow oncontextmenu events again, restoring the browser-native menu.'),
      _propRow('enabled', 'bool',
          'True if the browser-native menu is currently allowed (the default).'),
      const SizedBox(height: 12),
      const Text(
        'The pair must be balanced. Calling disableContextMenu repeatedly '
        'is safe (the second call is a no-op while the menu is already '
        'disabled), but failing to re-enable on dispose leaves the '
        'browser-native menu suppressed for the rest of the page session, '
        'which is bad citizenship.',
        style: TextStyle(fontSize: 12, color: cQuillInk, height: 1.45),
      ),
      const SizedBox(height: 10),
      _patternBlock(
        'Lifecycle pattern: paired with initState/dispose',
        'Disable in initState, restore in dispose. Keep the call points '
            'as close to the lifecycle boundary as possible -- never in '
            'didChangeDependencies, where the call could fire many times.',
        const <String>[
          '@override',
          'void initState() {',
          '  super.initState();',
          '  if (kIsWeb) {',
          '    BrowserContextMenu.disableContextMenu();',
          '  }',
          '}',
          '',
          '@override',
          'void dispose() {',
          '  if (kIsWeb) {',
          '    BrowserContextMenu.enableContextMenu();',
          '  }',
          '  super.dispose();',
          '}',
        ],
      ),
      const SizedBox(height: 6),
      const Text(
        'Edge case: some browsers (notably Safari) may prompt the user '
        'before allowing the page to suppress the context menu. The '
        'returned Future may complete after a noticeable delay if so. '
        'Do not block the UI thread waiting for it.',
        style: TextStyle(
            fontSize: 11,
            fontStyle: FontStyle.italic,
            color: cTwilightDusk),
      ),
    ],
  );
}

// =============================================================================
//  SECTION 13 -- DO / AVOID callouts.
// =============================================================================
//  Pairs of green-cove "do" rules and seal-vermilion "avoid" warnings.
// =============================================================================
Widget _buildSection13DoAvoid() {
  return _sectionCard(
    title: '13 -- DO / AVOID',
    accent: cSealVerm,
    children: [
      _doRow(
          'Use ContextMenuButtonType.* for cut/copy/paste/etc.',
          'Get free localisation, free icons, free platform-default '
              'ordering, and free overflow handling. The framework knows '
              'better than you what these buttons should look like.'),
      _avoidRow(
          'Do not invent custom items for cut/copy/paste',
          'A custom item with label="Copy" loses the localised label, '
              'loses the icon, loses the ordering. Use '
              'ContextMenuButtonType.copy with a null label instead.'),
      _doRow(
          'Always supply a label for ContextMenuButtonType.custom',
          'Custom items have no platform default label. Without one the '
              'rendered button is empty space.'),
      _avoidRow(
          'Do not call ContextMenuController.show() in build()',
          'show() schedules an Overlay insert. Calling it from build is '
              'a layout violation. Wire it from a gesture or '
              'addPostFrameCallback.'),
      _doRow(
          'Pair BrowserContextMenu.disable with .enable',
          'Always balance lifecycle calls. Disable in initState, '
              'restore in dispose. Suppressing the browser menu '
              'permanently is bad citizenship.'),
      _avoidRow(
          'Do not assume liveTextInput is supported',
          'The type only renders on iOS devices that support Live Text. '
              'On other platforms it is silently dropped. Do not gate '
              'critical functionality behind it.'),
      _doRow(
          'Use copyWith to override individual fields',
          'Replacing handlers via copyWith preserves the localised label '
              'and the platform default ordering. Building a fresh item '
              'loses both.'),
      _avoidRow(
          'Do not cache button items across editor instances',
          'Each EditableTextState has its own controller; the items '
              'reference its private state. Reusing items across editors '
              'can fire callbacks against the wrong selection.'),
    ],
  );
}

Widget _doRow(String head, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: cCoveMoss.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(4),
      border: Border(
        left: BorderSide(color: cCoveMoss, width: 3),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 36,
          child: Text(
            'DO',
            style: TextStyle(
              color: cCoveShadow,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12, color: cQuillInk, height: 1.45),
              children: [
                TextSpan(
                    text: '$head\n',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _avoidRow(String head, String body) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: cSealVerm.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(4),
      border: Border(
        left: BorderSide(color: cSealVerm, width: 3),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 56,
          child: Text(
            'AVOID',
            style: TextStyle(
              color: cSealVerm,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12, color: cQuillInk, height: 1.45),
              children: [
                TextSpan(
                    text: '$head\n',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 14 -- Recipes & glossary footer.
// =============================================================================
//  Final card combining a glossary of terms used throughout the file with
//  a short recap of the journey. Marks the visual end of the field guide.
// =============================================================================
Widget _buildSection14Recipes() {
  return _sectionCard(
    title: '14 -- Recipes, Glossary, and Recap',
    accent: cOliveCanopy,
    children: [
      const Text(
        'Glossary',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cOliveDeep, fontSize: 13),
      ),
      const SizedBox(height: 4),
      _glossaryRow('button item',
          'A ContextMenuButtonItem -- callback + type + optional label.'),
      _glossaryRow('button type',
          'A ContextMenuButtonType enum case identifying the button\'s role.'),
      _glossaryRow('controller',
          'A ContextMenuController instance managing show/remove of an overlay menu.'),
      _glossaryRow('adaptive toolbar',
          'AdaptiveTextSelectionToolbar -- picks Material/Cupertino/desktop variant by platform.'),
      _glossaryRow('anchor pair',
          'TextSelectionToolbarAnchors -- primary + optional secondary anchor for placement.'),
      _glossaryRow('overlay',
          'The Flutter Overlay where the toolbar is inserted; lives above the editing region.'),
      _glossaryRow('browser context menu',
          'The browser-native right-click menu that competes with the Flutter menu on web.'),
      _glossaryRow('platform-default label',
          'The localised label the framework injects when ContextMenuButtonItem.label is null and the type is non-custom.'),
      _glossaryRow('overflow caret',
          'The vertical-dots affordance on Material toolbars when items exceed the visible row.'),
      _glossaryRow('chevron arrow',
          'The trailing chevron on iOS Cupertino toolbars indicating more pages of items.'),
      _glossaryRow('section divider',
          'A 1px hairline that separates logical groups in the macOS desktop variant.'),
      _glossaryRow('live text input',
          'iOS-specific camera capture flow exposed through ContextMenuButtonType.liveTextInput.'),
      const SizedBox(height: 12),
      const Text(
        'Recap',
        style: TextStyle(
            fontWeight: FontWeight.bold, color: cOliveDeep, fontSize: 13),
      ),
      const SizedBox(height: 4),
      const Text(
        'The context-menu system in Flutter is shaped by three values: '
        'anchors (where), button items (what), and the AdaptiveTextSelectionToolbar '
        'or ContextMenuController (how). Each platform consumes the same '
        'invariant inputs and produces a visually distinct menu, all with '
        'no platform-specific code in your application. BrowserContextMenu '
        'is the small but essential web addendum that lets the Flutter menu '
        'win the right-click race against the browser. Mastering all '
        'three is the difference between a menu that lands in unexpected '
        'places, mis-localises its labels, or competes with the browser, '
        'and one that simply works.',
        style: TextStyle(
            fontSize: 12, color: cQuillInk, height: 1.55),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cOliveDeep,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Two pins, one anchor pair, ten button types, four platform '
          'roosts on a single olive branch -- the rookery is balanced.',
          style: TextStyle(
            color: cBrassyGlow,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
      ),
    ],
  );
}

Widget _glossaryRow(String term, String definition) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(
            term,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: cBrassyEmber,
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          child: Text(
            definition,
            style: const TextStyle(fontSize: 12, color: cQuillInk),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  Shared section-card helper.
// =============================================================================
Widget _sectionCard({
  required String title,
  required Color accent,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cTwilightIvory,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: cRookBeak.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: cTwilightIvory,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

// =============================================================================
//  END OF FILE -- ContextMenuController Rookery Olive Field Guide
// =============================================================================
//
//  Closing reflections, kept in the file so future maintainers can read
//  the intent without archaeologising through git blame:
//
//   * Every ContextMenuButtonItem referenced is constructed for real at the
//     top of build(). We do not stringify fake items -- we instantiate
//     them with real callbacks, real type values, real labels (where set),
//     and read .type/.label/.runtimeType through the genuine API.
//
//   * ContextMenuController is also instantiated for real, with its
//     .isShown and .runtimeType properties read live. We deliberately
//     do not call .show(), since show() requires a live Overlay and a
//     SchedulerBinding -- neither available in a one-shot D4rt build()
//     evaluation.
//
//   * The four platform mock toolbars in sections 6-9 are pedagogical.
//     They mimic what each platform's adaptive variant *would* render,
//     using static Containers, Rows, Columns, BoxDecorations, and a
//     small CustomPainter for the Cupertino tail. They are not the
//     real Material/Cupertino/desktop widgets -- those require live
//     theme contexts and more layout machinery than D4rt evaluates.
//
//   * Rookery Olive is a twilight-canopy theme: olive greens, rook
//     charcoals, twilight ivory backgrounds, brassy amber for hover
//     marks. It is unique to this file, intentionally distinct from the
//     "Pin Saffron" cork-board manual or the "Inkwell Verbena" margin
//     scribe that share its formal structure.
//
//   * No emoji appears anywhere in this file. The visual personality
//     comes entirely from layout, colour, and typography.
//
//   * No for-in over BridgedInstance values. All iteration over button
//     items, label lists, and macOS rows is performed with indexed for
//     loops, which D4rt evaluates as a structural for-loop and not as
//     a BridgedInstance for-in.
//
// -----------------------------------------------------------------------------
//  Appendix A -- Why a button-item type instead of a Widget?
// -----------------------------------------------------------------------------
//
//   The toolbar API could have taken a List<Widget> instead of
//   List<ContextMenuButtonItem>. Doing so would have meant:
//
//    1. The framework loses control over platform-default labels and
//       icons. You would need to re-implement them yourself.
//    2. The framework loses control over overflow behaviour. The Material
//       overflow caret is computed dynamically from the item count and
//       available width -- impossible to do correctly when the items are
//       opaque widgets.
//    3. The framework loses control over the Cupertino tail anchor and
//       chevron rendering. These are baked into the Cupertino toolbar
//       and would not appear if you supplied your own button widgets.
//
//   The button-item value type is the correct abstraction: small enough
//   to be platform-invariant, large enough to express callback + type +
//   label, and intentionally devoid of styling so each platform widget
//   can apply its own.
//
// -----------------------------------------------------------------------------
//  Appendix B -- The exact contract of show()
// -----------------------------------------------------------------------------
//
//   * context: must be an attached BuildContext. The framework walks up
//     to find the nearest Overlay; the controller's OverlayEntry is
//     inserted there.
//
//   * contextMenuBuilder: a WidgetBuilder. Invoked at insertion and on
//     every markNeedsBuild call. Returns the menu widget -- typically
//     an AdaptiveTextSelectionToolbar.buttonItems with a freshly
//     computed buttonItems list.
//
//   * debugRequiredFor: an optional widget reference used in debug-mode
//     assertions to verify the controller is being shown from the right
//     place in the tree. Has no effect in release builds.
//
//   The controller stores the OverlayEntry internally. Calling show()
//   on a controller that is already shown is a no-op. Calling show() on
//   any controller automatically removes whichever controller is
//   currently shown (system-wide single-instance invariant).
//
// -----------------------------------------------------------------------------
//  Appendix C -- Common bugs caused by mis-handling context menus
// -----------------------------------------------------------------------------
//
//   * "The toolbar shows in English on a French device": you used
//     ContextMenuButtonType.custom with label="Copy" instead of
//     ContextMenuButtonType.copy. Use the typed enum case so the
//     framework can localise.
//
//   * "The toolbar shows nothing on web": BrowserContextMenu was not
//     disabled, so the browser swallowed the right-click before
//     Flutter saw it. Disable the browser context menu in initState.
//
//   * "The custom item shows as a blank button": custom items require
//     a non-null label. Without it the rendered button has no text.
//
//   * "The toolbar appears below the selection on iOS instead of
//     above": secondaryAnchor was set to a position above the primary,
//     so the layout delegate flipped the orientation. Anchors must
//     follow the convention: primary above the selection, secondary
//     below.
//
//   * "Two toolbars overlap each other": you held two
//     ContextMenuController instances and called show() on both. Only
//     one can be shown system-wide; verify with controller.isShown
//     before showing.
//
//   * "The toolbar persists after the user navigates away": you forgot
//     to call controller.remove() in dispose(). The Overlay outlives
//     individual route widgets unless explicitly cleaned up.
//
//   * "Live Text Input does not appear on Android": that type is iOS-
//     only. The type is silently dropped on other platforms. Use a
//     custom item or a different affordance for cross-platform OCR.
//
// -----------------------------------------------------------------------------
//  Appendix D -- Reading list inside the SDK
// -----------------------------------------------------------------------------
//
//   * package:flutter/src/widgets/context_menu_button_item.dart
//       Defines ContextMenuButtonItem and ContextMenuButtonType.
//       The smallest of the files referenced -- worth reading first.
//
//   * package:flutter/src/widgets/context_menu_controller.dart
//       Defines ContextMenuController and the OverlayEntry management.
//       The single-instance system-wide invariant is enforced here.
//
//   * package:flutter/src/widgets/adaptive_text_selection_toolbar.dart
//       The platform-dispatch logic that picks Material/Cupertino/
//       desktop variants. The buttonItems-to-button widget mapping
//       lives in each variant's source file.
//
//   * package:flutter/src/services/browser_context_menu.dart
//       BrowserContextMenu, the web-only platform channel for
//       suppressing the browser-native menu.
//
//   * package:flutter/src/material/text_selection_toolbar.dart
//       The Material variant. Implements the overflow caret logic.
//
//   * package:flutter/src/cupertino/text_selection_toolbar.dart
//       The Cupertino variant. Implements the tail-flipping logic and
//       the chevron overflow indicator.
//
//   * package:flutter/src/cupertino/desktop_text_selection_toolbar.dart
//       The macOS desktop variant. Implements the vertical menu layout
//       with section dividers and shortcut hints.
//
// -----------------------------------------------------------------------------
//  Appendix E -- Closing thought
// -----------------------------------------------------------------------------
//
//   ContextMenuController, ContextMenuButtonItem, and the adaptive
//   toolbar form one of the smallest yet most polymorphic surfaces in
//   the Flutter framework. Three values -- anchors, items, controller --
//   produce a fully native-feeling menu on every supported platform with
//   no platform-specific code in user space. The rookery's coves are
//   hidden but uniform: every roost has the same shape; every twig is
//   different. Master the value types, leave the painting to the
//   platforms, and the menu lands where it should every time.
//
// =============================================================================
