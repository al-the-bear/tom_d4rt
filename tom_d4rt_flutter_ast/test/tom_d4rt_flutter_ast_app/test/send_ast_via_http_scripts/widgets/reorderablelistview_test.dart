// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

// ============================================================================
// ReorderableListView - Mosaic Plum Edition
// ----------------------------------------------------------------------------
// A deep, hand-written, scroll-through demo for the Flutter ReorderableListView
// widget rendered under the d4rt analyzer-free interpreter.
//
// Theme: "Mosaic Plum" - a tessellated palette of plum, mulberry, lilac and
// gilded accents reminiscent of a stained-glass mosaic at twilight. The
// composition emphasizes contrast between deep wine purples, blushing rose
// pinks, and warm amber highlights so each ReorderableListView snapshot reads
// as a distinct mosaic tile within the larger demo page.
//
// What this file demonstrates:
//   * The anatomy of a ReorderableListView, including the contractual onReorder
//     index semantics and the unique-Key requirement for children.
//   * Static, snapshot-style usage of ReorderableListView under a single build
//     pass - no StatefulWidget, no setState, no actual reordering.
//   * Use of header/footer slots, padding, scrollDirection, proxyDecorator,
//     buildDefaultDragHandles and the .builder constructor.
//   * Common pitfalls (mutating the children list mid-drag, omitting Keys,
//     unbounded shrinkWrap heights) and DO/AVOID callouts.
//   * Five canonical recipe code-snippets, a glossary of 15 terms, and a
//     decorative recap footer in the Mosaic Plum palette.
//
// Constraints (d4rt analyzer-free interpreter):
//   * build() runs once and returns a static widget tree. The reorder
//     callback is a no-op - drags are never actually performed in tests.
//   * No StatefulWidget, no setState, no for-in over BridgedInstance.
//   * Color alpha uses .withValues(alpha: ...).
//   * 5 to 15 narrative print(...) calls log palette swatches and structural
//     milestones during the single build pass.
//
// Layout outline:
//   The Scaffold body is a SingleChildScrollView whose Column contains
//   twelve sections. Each ReorderableListView snapshot lives inside a
//   bounded SizedBox(height: 240) so its inner scroll axis stays finite
//   inside the outer scroll view. Each child of every ReorderableListView
//   carries a unique ValueKey<String>, satisfying the framework contract.
// ============================================================================

import 'package:flutter/material.dart';

// ----------------------------------------------------------------------------
// MosaicPlumPalette - Mosaic Plum theme color constants.
// ----------------------------------------------------------------------------
class MosaicPlumPalette {
  // Deep wine plum, the foundation of the mosaic.
  static const Color deepPlum = Color(0xFF3D1A4A);
  // Mulberry, slightly redder than plum.
  static const Color mulberry = Color(0xFF6B2C5F);
  // Velvet violet, the body of most cards.
  static const Color velvet = Color(0xFF8E3D8A);
  // Lilac mist, the soft mid-tone.
  static const Color lilacMist = Color(0xFFB892C9);
  // Blush rose, the warmest accent.
  static const Color blushRose = Color(0xFFE5A4B8);
  // Gilded amber, the metallic highlight.
  static const Color gilded = Color(0xFFD4A24C);
  // Champagne, near-cream paper backdrop.
  static const Color champagne = Color(0xFFF7EFD9);
  // Inkwell, near-black text color.
  static const Color inkwell = Color(0xFF1B0F1F);
  // Sage glass, a cool counterpoint to all the warm purples.
  static const Color sageGlass = Color(0xFF7FA39A);
  // Twilight slate, the cool shadow tone.
  static const Color twilightSlate = Color(0xFF453E55);
  // Pearl, the lightest highlight.
  static const Color pearl = Color(0xFFFFF8F0);
  // Garnet, deep red accent for warnings.
  static const Color garnet = Color(0xFF7A1F2B);
  // Frosted lavender, soft tile fill.
  static const Color frostedLavender = Color(0xFFD8C7E2);
  // Mosaic gold-leaf, a brighter gilded.
  static const Color goldLeaf = Color(0xFFE8C572);
}

// ----------------------------------------------------------------------------
// build - top-level entry point invoked by the d4rt interpreter once.
// ----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('[MosaicPlum] booting ReorderableListView demo build()');
  print('[MosaicPlum] palette anchor: deepPlum=#3D1A4A, gilded=#D4A24C');
  print('[MosaicPlum] sections to render: 12');
  print('[MosaicPlum] reorder callbacks are no-ops in interpreter mode');
  print('[MosaicPlum] every direct child carries a unique ValueKey<String>');

  return Scaffold(
    backgroundColor: MosaicPlumPalette.champagne,
    appBar: AppBar(
      backgroundColor: MosaicPlumPalette.deepPlum,
      foregroundColor: MosaicPlumPalette.pearl,
      elevation: 4,
      title: const Text(
        'ReorderableListView - Mosaic Plum Edition',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTitleBanner(),
          const SizedBox(height: 28),
          buildAnatomyProseCard(),
          const SizedBox(height: 28),
          buildPropertyAnatomyPanel(),
          const SizedBox(height: 28),
          buildSectionHeader('4. Live Gallery - Four Mosaic Tiles'),
          const SizedBox(height: 12),
          buildGalleryPlaylist(),
          const SizedBox(height: 18),
          buildGalleryTodoList(),
          const SizedBox(height: 18),
          buildGalleryColorStack(),
          const SizedBox(height: 18),
          buildGalleryRecipeSteps(),
          const SizedBox(height: 28),
          buildBuilderShowcase(),
          const SizedBox(height: 28),
          buildHeaderFooterShowcase(),
          const SizedBox(height: 28),
          buildIndexSemanticsProse(),
          const SizedBox(height: 28),
          buildProxyDecoratorShowcase(),
          const SizedBox(height: 28),
          buildDoAvoidCallouts(),
          const SizedBox(height: 28),
          buildCodeSnippetCards(),
          const SizedBox(height: 28),
          buildGlossary(),
          const SizedBox(height: 28),
          buildRecapFooter(),
          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 1 - Title banner with palette swatches.
// ----------------------------------------------------------------------------
Widget buildTitleBanner() {
  print('[MosaicPlum] section 1: title banner with palette swatches');
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          MosaicPlumPalette.deepPlum,
          MosaicPlumPalette.mulberry,
          MosaicPlumPalette.velvet,
        ],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: MosaicPlumPalette.inkwell.withValues(alpha: 0.32),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      border: Border.all(
        color: MosaicPlumPalette.gilded.withValues(alpha: 0.6),
        width: 2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: MosaicPlumPalette.gilded,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'WIDGET STUDY',
                style: TextStyle(
                  color: MosaicPlumPalette.inkwell,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Mosaic Plum',
              style: TextStyle(
                color: MosaicPlumPalette.pearl,
                fontWeight: FontWeight.w300,
                fontSize: 14,
                letterSpacing: 2.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'ReorderableListView',
          style: TextStyle(
            color: MosaicPlumPalette.pearl,
            fontWeight: FontWeight.w800,
            fontSize: 34,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Drag-to-reorder vertical (and horizontal) lists with Material polish.',
          style: TextStyle(
            color: MosaicPlumPalette.frostedLavender.withValues(alpha: 0.95),
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18),
        buildPaletteSwatchRow(),
      ],
    ),
  );
}

Widget buildPaletteSwatchRow() {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: <Widget>[
      buildSwatch('deepPlum', MosaicPlumPalette.deepPlum, MosaicPlumPalette.pearl),
      buildSwatch('mulberry', MosaicPlumPalette.mulberry, MosaicPlumPalette.pearl),
      buildSwatch('velvet', MosaicPlumPalette.velvet, MosaicPlumPalette.pearl),
      buildSwatch('lilacMist', MosaicPlumPalette.lilacMist, MosaicPlumPalette.inkwell),
      buildSwatch('blushRose', MosaicPlumPalette.blushRose, MosaicPlumPalette.inkwell),
      buildSwatch('gilded', MosaicPlumPalette.gilded, MosaicPlumPalette.inkwell),
      buildSwatch('goldLeaf', MosaicPlumPalette.goldLeaf, MosaicPlumPalette.inkwell),
      buildSwatch('champagne', MosaicPlumPalette.champagne, MosaicPlumPalette.inkwell),
      buildSwatch('sageGlass', MosaicPlumPalette.sageGlass, MosaicPlumPalette.inkwell),
      buildSwatch('twilightSlate', MosaicPlumPalette.twilightSlate, MosaicPlumPalette.pearl),
      buildSwatch('garnet', MosaicPlumPalette.garnet, MosaicPlumPalette.pearl),
      buildSwatch('frostedLavender', MosaicPlumPalette.frostedLavender, MosaicPlumPalette.inkwell),
    ],
  );
}

Widget buildSwatch(String name, Color fill, Color textColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: fill,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: MosaicPlumPalette.pearl.withValues(alpha: 0.4),
        width: 1,
      ),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: textColor,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 2 - Prose anatomy card.
// ----------------------------------------------------------------------------
Widget buildAnatomyProseCard() {
  print('[MosaicPlum] section 2: anatomy prose card');
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.pearl,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.lilacMist,
        width: 1.4,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: MosaicPlumPalette.velvet.withValues(alpha: 0.10),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProseHeading('2. Anatomy of a ReorderableListView'),
        const SizedBox(height: 10),
        buildProseParagraph(
          'A ReorderableListView is a Material list whose children can be '
          'rearranged by the user via long-press drag. Its core contract is '
          'a callback - onReorder(int oldIndex, int newIndex) - that fires '
          'when a drag concludes over a new slot. The widget itself does '
          'not mutate its children list; that is your responsibility.',
        ),
        const SizedBox(height: 10),
        buildProseParagraph(
          'Every direct child must carry a unique Key. This is how the '
          'framework tracks an element across reorders without confusing '
          'one tile for another. Forgetting a Key (or reusing an index '
          'as a key after a reorder) is the most common cause of broken '
          'animations and spurious rebuilds.',
        ),
        const SizedBox(height: 10),
        buildProseParagraph(
          'The onReorder index semantics deserve special attention. Flutter '
          'reports newIndex relative to the list BEFORE the dragged item '
          'is removed. When the dragged item moves DOWN, you must subtract '
          'one from newIndex before splicing it back in. Otherwise it '
          'lands one slot too far.',
        ),
        const SizedBox(height: 10),
        buildProseParagraph(
          'In this demo every ReorderableListView is rendered inside a '
          'fixed-height SizedBox so its scroll axis stays bounded inside '
          'the outer SingleChildScrollView. The reorder callback is a '
          'no-op because the d4rt interpreter renders one static frame.',
        ),
      ],
    ),
  );
}

Widget buildProseHeading(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: MosaicPlumPalette.deepPlum,
      fontWeight: FontWeight.w800,
      fontSize: 19,
      letterSpacing: 0.3,
    ),
  );
}

Widget buildProseParagraph(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: MosaicPlumPalette.inkwell,
      fontSize: 14.5,
      height: 1.45,
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 3 - Property anatomy panel: 14 properties with swatches.
// ----------------------------------------------------------------------------
Widget buildPropertyAnatomyPanel() {
  print('[MosaicPlum] section 3: property anatomy panel (14 rows)');
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.frostedLavender.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.velvet.withValues(alpha: 0.4),
        width: 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProseHeading('3. Property Anatomy'),
        const SizedBox(height: 14),
        buildPropertyRow('children', 'List<Widget> with unique Keys (required).',
            MosaicPlumPalette.deepPlum),
        buildPropertyRow('onReorder', '(oldIndex, newIndex) callback (required).',
            MosaicPlumPalette.mulberry),
        buildPropertyRow('onReorderStart', 'Fires when a drag starts.',
            MosaicPlumPalette.velvet),
        buildPropertyRow('onReorderEnd', 'Fires when a drag finishes.',
            MosaicPlumPalette.lilacMist),
        buildPropertyRow('padding', 'EdgeInsets around the list.',
            MosaicPlumPalette.blushRose),
        buildPropertyRow('header', 'Optional non-reorderable widget at the top.',
            MosaicPlumPalette.gilded),
        buildPropertyRow('footer', 'Optional non-reorderable widget at the bottom.',
            MosaicPlumPalette.goldLeaf),
        buildPropertyRow('scrollDirection', 'Axis.vertical (default) or Axis.horizontal.',
            MosaicPlumPalette.sageGlass),
        buildPropertyRow('proxyDecorator', 'Wraps the dragged child mid-drag.',
            MosaicPlumPalette.twilightSlate),
        buildPropertyRow('buildDefaultDragHandles',
            'true -> trailing handle on each tile.',
            MosaicPlumPalette.garnet),
        buildPropertyRow('dragStartBehavior',
            'DragStartBehavior.start vs .down.',
            MosaicPlumPalette.deepPlum),
        buildPropertyRow('physics',
            'ScrollPhysics for the inner scroll view.',
            MosaicPlumPalette.mulberry),
        buildPropertyRow('shrinkWrap',
            'Size to children - only inside bounded heights.',
            MosaicPlumPalette.velvet),
        buildPropertyRow('reverse',
            'Render bottom-to-top (rare for reorderable lists).',
            MosaicPlumPalette.lilacMist),
      ],
    ),
  );
}

Widget buildPropertyRow(String name, String desc, Color swatchColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: swatchColor,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: MosaicPlumPalette.inkwell.withValues(alpha: 0.35),
              width: 0.6,
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 170,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: MosaicPlumPalette.deepPlum,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: MosaicPlumPalette.inkwell,
              fontSize: 13.2,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 4a - Live gallery: Playlist
// ----------------------------------------------------------------------------
Widget buildGalleryPlaylist() {
  print('[MosaicPlum] section 4a: playlist ReorderableListView snapshot');
  return buildGalleryFrame(
    title: 'Playlist - Velvet Mixtape',
    subtitle: 'Drag handles, alternating tile fills.',
    accent: MosaicPlumPalette.mulberry,
    child: SizedBox(
      height: 240,
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        buildDefaultDragHandles: true,
        onReorder: (int oldIndex, int newIndex) {
          // No-op in d4rt interpreter mode - drag callbacks never fire.
        },
        children: <Widget>[
          buildPlaylistTile('a', 'Plum Velvet Sunrise', '3:42',
              MosaicPlumPalette.deepPlum),
          buildPlaylistTile('b', 'Mulberry Boulevard', '4:18',
              MosaicPlumPalette.mulberry),
          buildPlaylistTile('c', 'Lilac Mist Cassette', '2:55',
              MosaicPlumPalette.velvet),
          buildPlaylistTile('d', 'Gilded Half-Step', '5:03',
              MosaicPlumPalette.gilded),
          buildPlaylistTile('e', 'Garnet Lullaby', '3:09',
              MosaicPlumPalette.garnet),
          buildPlaylistTile('f', 'Sage Glass Waltz', '4:44',
              MosaicPlumPalette.sageGlass),
        ],
      ),
    ),
  );
}

Widget buildPlaylistTile(String id, String title, String duration, Color tint) {
  return Container(
    key: ValueKey<String>('playlist-$id'),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: MosaicPlumPalette.gilded.withValues(alpha: 0.5),
        width: 1,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: MosaicPlumPalette.pearl.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.music_note,
            color: MosaicPlumPalette.deepPlum,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: MosaicPlumPalette.pearl,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Text(
                'duration $duration',
                style: TextStyle(
                  color: MosaicPlumPalette.pearl.withValues(alpha: 0.85),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.drag_handle,
          color: MosaicPlumPalette.pearl,
          size: 18,
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 4b - Live gallery: Todo list
// ----------------------------------------------------------------------------
Widget buildGalleryTodoList() {
  print('[MosaicPlum] section 4b: todo list ReorderableListView snapshot');
  return buildGalleryFrame(
    title: 'Todo List - Champagne Index Cards',
    subtitle: 'Padded list with index numbers and gilded checkboxes.',
    accent: MosaicPlumPalette.gilded,
    child: SizedBox(
      height: 240,
      child: ReorderableListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        buildDefaultDragHandles: true,
        onReorder: (int oldIndex, int newIndex) {},
        children: <Widget>[
          buildTodoTile(0, 'Sketch the mosaic borders'),
          buildTodoTile(1, 'Choose plum vs mulberry for header'),
          buildTodoTile(2, 'Wire the onReorder callback'),
          buildTodoTile(3, 'Add unique ValueKeys to every tile'),
          buildTodoTile(4, 'Test horizontal scrollDirection'),
          buildTodoTile(5, 'Document buildDefaultDragHandles'),
        ],
      ),
    ),
  );
}

Widget buildTodoTile(int index, String text) {
  return Container(
    key: ValueKey<String>('todo-$index'),
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.champagne,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: MosaicPlumPalette.gilded.withValues(alpha: 0.7),
        width: 1.2,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            border: Border.all(
              color: MosaicPlumPalette.deepPlum,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(4),
            color: MosaicPlumPalette.pearl,
          ),
          child: const Center(
            child: Text(
              '+',
              style: TextStyle(
                color: MosaicPlumPalette.deepPlum,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: MosaicPlumPalette.deepPlum,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '#$index',
            style: const TextStyle(
              color: MosaicPlumPalette.pearl,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: MosaicPlumPalette.inkwell,
              fontSize: 13.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 4c - Live gallery: Color stack (horizontal)
// ----------------------------------------------------------------------------
Widget buildGalleryColorStack() {
  print('[MosaicPlum] section 4c: horizontal color stack snapshot');
  return buildGalleryFrame(
    title: 'Color Stack - Horizontal Mosaic',
    subtitle: 'scrollDirection: Axis.horizontal, custom drag handles off.',
    accent: MosaicPlumPalette.velvet,
    child: SizedBox(
      height: 240,
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {},
        children: <Widget>[
          buildColorChip('p1', 'Plum', MosaicPlumPalette.deepPlum),
          buildColorChip('p2', 'Mulberry', MosaicPlumPalette.mulberry),
          buildColorChip('p3', 'Velvet', MosaicPlumPalette.velvet),
          buildColorChip('p4', 'Lilac', MosaicPlumPalette.lilacMist),
          buildColorChip('p5', 'Blush', MosaicPlumPalette.blushRose),
          buildColorChip('p6', 'Gilded', MosaicPlumPalette.gilded),
          buildColorChip('p7', 'Sage', MosaicPlumPalette.sageGlass),
          buildColorChip('p8', 'Garnet', MosaicPlumPalette.garnet),
        ],
      ),
    ),
  );
}

Widget buildColorChip(String id, String label, Color tint) {
  return Container(
    key: ValueKey<String>('color-$id'),
    width: 130,
    margin: const EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: MosaicPlumPalette.inkwell.withValues(alpha: 0.4),
        width: 1,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.palette,
            color: MosaicPlumPalette.pearl,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: MosaicPlumPalette.pearl,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'id=$id',
            style: TextStyle(
              color: MosaicPlumPalette.pearl.withValues(alpha: 0.85),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 4d - Live gallery: Recipe steps
// ----------------------------------------------------------------------------
Widget buildGalleryRecipeSteps() {
  print('[MosaicPlum] section 4d: recipe steps snapshot');
  return buildGalleryFrame(
    title: 'Recipe Steps - Plum Tart',
    subtitle: 'Step labels and prep durations.',
    accent: MosaicPlumPalette.blushRose,
    child: SizedBox(
      height: 240,
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        buildDefaultDragHandles: true,
        onReorder: (int oldIndex, int newIndex) {},
        children: <Widget>[
          buildRecipeStep(1, 'Macerate plums in mulberry sugar', '15 min'),
          buildRecipeStep(2, 'Roll out shortcrust pastry', '10 min'),
          buildRecipeStep(3, 'Blind-bake the shell', '20 min'),
          buildRecipeStep(4, 'Whisk lilac-vanilla custard', '8 min'),
          buildRecipeStep(5, 'Arrange plums in mosaic spiral', '12 min'),
          buildRecipeStep(6, 'Bake until gilded edges form', '35 min'),
        ],
      ),
    ),
  );
}

Widget buildRecipeStep(int n, String text, String duration) {
  return Container(
    key: ValueKey<String>('recipe-$n'),
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.pearl,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: MosaicPlumPalette.blushRose,
        width: 1.4,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: MosaicPlumPalette.mulberry,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              '$n',
              style: const TextStyle(
                color: MosaicPlumPalette.pearl,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: MosaicPlumPalette.inkwell,
              fontSize: 13.4,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: MosaicPlumPalette.gilded.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            duration,
            style: const TextStyle(
              color: MosaicPlumPalette.inkwell,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Gallery frame helper.
// ----------------------------------------------------------------------------
Widget buildGalleryFrame({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget child,
}) {
  return Container(
    decoration: BoxDecoration(
      color: MosaicPlumPalette.pearl,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: accent.withValues(alpha: 0.65),
        width: 1.3,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.20),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: MosaicPlumPalette.inkwell,
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 5 - ReorderableListView.builder showcase.
// ----------------------------------------------------------------------------
Widget buildBuilderShowcase() {
  print('[MosaicPlum] section 5: ReorderableListView.builder showcase');
  return buildGalleryFrame(
    title: '5. ReorderableListView.builder',
    subtitle: 'itemBuilder + itemCount; ideal for long virtualized lists.',
    accent: MosaicPlumPalette.twilightSlate,
    child: SizedBox(
      height: 260,
      child: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        itemCount: 8,
        buildDefaultDragHandles: true,
        onReorder: (int oldIndex, int newIndex) {},
        itemBuilder: (BuildContext context, int index) {
          return buildBuilderTile(index);
        },
      ),
    ),
  );
}

Widget buildBuilderTile(int index) {
  final List<Color> tints = <Color>[
    MosaicPlumPalette.deepPlum,
    MosaicPlumPalette.mulberry,
    MosaicPlumPalette.velvet,
    MosaicPlumPalette.lilacMist,
    MosaicPlumPalette.blushRose,
    MosaicPlumPalette.gilded,
    MosaicPlumPalette.sageGlass,
    MosaicPlumPalette.garnet,
  ];
  final Color tint = tints[index % tints.length];
  return Container(
    key: ValueKey<String>('builder-$index'),
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.92),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: MosaicPlumPalette.pearl,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: MosaicPlumPalette.deepPlum,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Builder item index=$index - built lazily on demand',
            style: const TextStyle(
              color: MosaicPlumPalette.pearl,
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 6 - Header / footer slots showcase.
// ----------------------------------------------------------------------------
Widget buildHeaderFooterShowcase() {
  print('[MosaicPlum] section 6: header/footer slot showcase');
  return buildGalleryFrame(
    title: '6. Header & Footer Slots',
    subtitle: 'Non-reorderable banners pinned above and below the children.',
    accent: MosaicPlumPalette.gilded,
    child: SizedBox(
      height: 280,
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        buildDefaultDragHandles: true,
        onReorder: (int oldIndex, int newIndex) {},
        header: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MosaicPlumPalette.deepPlum,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: <Widget>[
              Icon(Icons.flag, color: MosaicPlumPalette.gilded, size: 18),
              SizedBox(width: 8),
              Text(
                'HEADER - non-reorderable',
                style: TextStyle(
                  color: MosaicPlumPalette.pearl,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        footer: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MosaicPlumPalette.gilded,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: <Widget>[
              Icon(Icons.bookmark, color: MosaicPlumPalette.deepPlum, size: 18),
              SizedBox(width: 8),
              Text(
                'FOOTER - non-reorderable',
                style: TextStyle(
                  color: MosaicPlumPalette.deepPlum,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          buildHfTile('hf-a', 'Reorderable A', MosaicPlumPalette.mulberry),
          buildHfTile('hf-b', 'Reorderable B', MosaicPlumPalette.velvet),
          buildHfTile('hf-c', 'Reorderable C', MosaicPlumPalette.lilacMist),
          buildHfTile('hf-d', 'Reorderable D', MosaicPlumPalette.blushRose),
          buildHfTile('hf-e', 'Reorderable E', MosaicPlumPalette.sageGlass),
        ],
      ),
    ),
  );
}

Widget buildHfTile(String id, String text, Color tint) {
  return Container(
    key: ValueKey<String>(id),
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: MosaicPlumPalette.pearl,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 7 - onReorder index semantics prose.
// ----------------------------------------------------------------------------
Widget buildIndexSemanticsProse() {
  print('[MosaicPlum] section 7: index semantics prose with diagrams');
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.pearl,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.deepPlum.withValues(alpha: 0.5),
        width: 1.4,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProseHeading('7. onReorder Index Semantics'),
        const SizedBox(height: 10),
        buildProseParagraph(
          'When a drag concludes, ReorderableListView calls '
          'onReorder(oldIndex, newIndex). The trick is that newIndex is '
          'reported relative to the list BEFORE you remove the dragged '
          'tile. If oldIndex < newIndex (the user dragged DOWN), you '
          'must subtract one from newIndex before calling insert.',
        ),
        const SizedBox(height: 14),
        buildDiagramRow(
          'BEFORE',
          <String>['A', 'B', 'C', 'D', 'E'],
          1,
        ),
        const SizedBox(height: 8),
        buildProseParagraph(
          'User drags B (oldIndex=1) past D toward E. Flutter reports '
          'newIndex=4. Naive: insert(4, B) -> [A, C, D, B, E].',
        ),
        const SizedBox(height: 8),
        buildDiagramRow(
          'NAIVE',
          <String>['A', 'C', 'D', 'B', 'E'],
          3,
        ),
        const SizedBox(height: 8),
        buildProseParagraph(
          'Correct: subtract one -> insert(3, B) -> [A, C, D, B, E]. '
          'The subtle bug surfaces when you compute the splice without '
          'first removing the source item. The canonical recipe:',
        ),
        const SizedBox(height: 10),
        buildCodeBox(
          'onReorder: (int oldIndex, int newIndex) {\n'
          '  setState(() {\n'
          '    if (newIndex > oldIndex) newIndex -= 1;\n'
          '    final item = items.removeAt(oldIndex);\n'
          '    items.insert(newIndex, item);\n'
          '  });\n'
          '},',
        ),
        const SizedBox(height: 10),
        buildProseParagraph(
          'This off-by-one is the single most common ReorderableListView '
          'bug. Memorize it.',
        ),
      ],
    ),
  );
}

Widget buildDiagramRow(String label, List<String> items, int highlightIndex) {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    final bool hi = i == highlightIndex;
    tiles.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hi ? MosaicPlumPalette.gilded : MosaicPlumPalette.lilacMist,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: MosaicPlumPalette.deepPlum,
            width: hi ? 2 : 1,
          ),
        ),
        child: Text(
          '${items[i]} ($i)',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: MosaicPlumPalette.inkwell,
          ),
        ),
      ),
    );
  }
  return Row(
    children: <Widget>[
      SizedBox(
        width: 70,
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: MosaicPlumPalette.deepPlum,
            fontSize: 12,
            letterSpacing: 0.6,
          ),
        ),
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: tiles,
        ),
      ),
    ],
  );
}

Widget buildCodeBox(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.inkwell,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: MosaicPlumPalette.gilded.withValues(alpha: 0.6),
        width: 1,
      ),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        color: MosaicPlumPalette.goldLeaf,
        fontSize: 12.6,
        height: 1.35,
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 8 - proxyDecorator showcase.
// ----------------------------------------------------------------------------
Widget buildProxyDecoratorShowcase() {
  print('[MosaicPlum] section 8: proxyDecorator showcase');
  return buildGalleryFrame(
    title: '8. proxyDecorator',
    subtitle: 'Wrap the dragged child in a tinted, elevated Container.',
    accent: MosaicPlumPalette.sageGlass,
    child: SizedBox(
      height: 240,
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        buildDefaultDragHandles: true,
        onReorder: (int oldIndex, int newIndex) {},
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            elevation: 8,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: MosaicPlumPalette.gilded.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: MosaicPlumPalette.gilded,
                  width: 2,
                ),
              ),
              child: child,
            ),
          );
        },
        children: <Widget>[
          buildProxyTile('px-a', 'Proxy tile A', MosaicPlumPalette.deepPlum),
          buildProxyTile('px-b', 'Proxy tile B', MosaicPlumPalette.mulberry),
          buildProxyTile('px-c', 'Proxy tile C', MosaicPlumPalette.velvet),
          buildProxyTile('px-d', 'Proxy tile D', MosaicPlumPalette.lilacMist),
          buildProxyTile('px-e', 'Proxy tile E', MosaicPlumPalette.blushRose),
        ],
      ),
    ),
  );
}

Widget buildProxyTile(String id, String text, Color tint) {
  return Container(
    key: ValueKey<String>(id),
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.88),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.drag_indicator, color: MosaicPlumPalette.pearl),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: MosaicPlumPalette.pearl,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: MosaicPlumPalette.pearl.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            id,
            style: const TextStyle(
              color: MosaicPlumPalette.pearl,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 9 - DO/AVOID callouts.
// ----------------------------------------------------------------------------
Widget buildDoAvoidCallouts() {
  print('[MosaicPlum] section 9: DO/AVOID callouts (10 rules)');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.frostedLavender.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.velvet.withValues(alpha: 0.5),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProseHeading('9. DO / AVOID'),
        const SizedBox(height: 12),
        buildCalloutRow(true, 'DO assign a unique Key (ValueKey) to every direct child.'),
        buildCalloutRow(false, 'AVOID using list indices as keys - they collide after reorder.'),
        buildCalloutRow(true, 'DO subtract one from newIndex when newIndex > oldIndex.'),
        buildCalloutRow(false, 'AVOID mutating the children list mid-drag from another thread.'),
        buildCalloutRow(true, 'DO wrap horizontal usages in a SizedBox with a finite height.'),
        buildCalloutRow(false, 'AVOID combining shrinkWrap=false with unbounded heights - layout error.'),
        buildCalloutRow(true, 'DO use ReorderableListView.builder for long virtualized lists.'),
        buildCalloutRow(false, 'AVOID rebuilding all children with new identities every frame.'),
        buildCalloutRow(true, 'DO supply a proxyDecorator if the dragged tile needs Material elevation.'),
        buildCalloutRow(false, 'AVOID nesting another ReorderableListView inside a child tile.'),
      ],
    ),
  );
}

Widget buildCalloutRow(bool isDo, String text) {
  final Color tint = isDo ? MosaicPlumPalette.sageGlass : MosaicPlumPalette.garnet;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isDo ? 'DO' : 'AVOID',
            style: const TextStyle(
              color: MosaicPlumPalette.pearl,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: MosaicPlumPalette.inkwell,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 10 - Code-snippet cards (5 canonical recipes).
// ----------------------------------------------------------------------------
Widget buildCodeSnippetCards() {
  print('[MosaicPlum] section 10: 5 code-snippet recipes');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.pearl,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.deepPlum.withValues(alpha: 0.4),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProseHeading('10. Canonical Recipes'),
        const SizedBox(height: 12),
        buildRecipeCard(
          'Recipe 1 - Minimum viable reorderable list',
          'ReorderableListView(\n'
          '  onReorder: (oldI, newI) {\n'
          '    if (newI > oldI) newI -= 1;\n'
          '    final v = items.removeAt(oldI);\n'
          '    items.insert(newI, v);\n'
          '  },\n'
          '  children: [\n'
          '    for (final it in items)\n'
          '      ListTile(key: ValueKey(it.id), title: Text(it.label)),\n'
          '  ],\n'
          ');',
        ),
        const SizedBox(height: 12),
        buildRecipeCard(
          'Recipe 2 - Lazy builder',
          'ReorderableListView.builder(\n'
          '  itemCount: items.length,\n'
          '  onReorder: handleReorder,\n'
          '  itemBuilder: (ctx, i) => ListTile(\n'
          '    key: ValueKey(items[i].id),\n'
          '    title: Text(items[i].label),\n'
          '  ),\n'
          ');',
        ),
        const SizedBox(height: 12),
        buildRecipeCard(
          'Recipe 3 - Custom proxyDecorator',
          'ReorderableListView(\n'
          '  onReorder: handleReorder,\n'
          '  proxyDecorator: (child, idx, anim) => Material(\n'
          '    elevation: 8,\n'
          '    color: Colors.amber.withValues(alpha: 0.3),\n'
          '    child: child,\n'
          '  ),\n'
          '  children: tiles,\n'
          ');',
        ),
        const SizedBox(height: 12),
        buildRecipeCard(
          'Recipe 4 - Header + footer',
          'ReorderableListView(\n'
          '  header: Text("PINNED HEADER"),\n'
          '  footer: Text("PINNED FOOTER"),\n'
          '  onReorder: handleReorder,\n'
          '  children: tiles,\n'
          ');',
        ),
        const SizedBox(height: 12),
        buildRecipeCard(
          'Recipe 5 - Custom drag handles',
          'ReorderableListView(\n'
          '  buildDefaultDragHandles: false,\n'
          '  onReorder: handleReorder,\n'
          '  children: [\n'
          '    for (int i = 0; i < items.length; i++)\n'
          '      Row(key: ValueKey(items[i].id), children: [\n'
          '        Expanded(child: Text(items[i].label)),\n'
          '        ReorderableDragStartListener(\n'
          '          index: i,\n'
          '          child: Icon(Icons.drag_handle),\n'
          '        ),\n'
          '      ]),\n'
          '  ],\n'
          ');',
        ),
      ],
    ),
  );
}

Widget buildRecipeCard(String title, String code) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: MosaicPlumPalette.deepPlum,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: MosaicPlumPalette.gilded,
            fontWeight: FontWeight.w700,
            fontSize: 12.5,
            letterSpacing: 0.4,
          ),
        ),
      ),
      const SizedBox(height: 6),
      buildCodeBox(code),
    ],
  );
}

// ----------------------------------------------------------------------------
// Section 11 - Glossary (15 terms).
// ----------------------------------------------------------------------------
Widget buildGlossary() {
  print('[MosaicPlum] section 11: glossary (15 terms)');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.lilacMist.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.velvet.withValues(alpha: 0.6),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildProseHeading('11. Glossary'),
        const SizedBox(height: 12),
        buildGlossaryTerm('children',
            'List of widgets, each requiring a unique Key.'),
        buildGlossaryTerm('onReorder',
            'Callback (oldIndex, newIndex) fired when a drag concludes.'),
        buildGlossaryTerm('oldIndex',
            'Position of the dragged tile before removal.'),
        buildGlossaryTerm('newIndex',
            'Target slot, reported relative to the unmodified list.'),
        buildGlossaryTerm('proxyDecorator',
            'Wrapper applied to the floating tile during a drag.'),
        buildGlossaryTerm('drag handle',
            'Visual affordance (default trailing icon) the user grabs.'),
        buildGlossaryTerm('header',
            'Optional non-reorderable widget pinned above children.'),
        buildGlossaryTerm('footer',
            'Optional non-reorderable widget pinned below children.'),
        buildGlossaryTerm('scrollDirection',
            'Axis.vertical or Axis.horizontal.'),
        buildGlossaryTerm('buildDefaultDragHandles',
            'When true, a trailing handle is auto-added on each tile.'),
        buildGlossaryTerm('dragStartBehavior',
            'Whether drags start on touch-down or first move.'),
        buildGlossaryTerm('shrinkWrap',
            'Size the list to its content; only safe inside a bounded box.'),
        buildGlossaryTerm('physics',
            'ScrollPhysics applied to the inner scroll view.'),
        buildGlossaryTerm('ValueKey',
            'Identity key derived from a value (use for unique IDs).'),
        buildGlossaryTerm('off-by-one',
            'The newIndex bug that arises if you forget to subtract one.'),
      ],
    ),
  );
}

Widget buildGlossaryTerm(String term, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170,
          child: Text(
            term,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: MosaicPlumPalette.deepPlum,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              color: MosaicPlumPalette.inkwell,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 12 - Recap footer.
// ----------------------------------------------------------------------------
Widget buildRecapFooter() {
  print('[MosaicPlum] section 12: recap footer');
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          MosaicPlumPalette.twilightSlate,
          MosaicPlumPalette.deepPlum,
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: MosaicPlumPalette.gilded.withValues(alpha: 0.55),
        width: 1.6,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: MosaicPlumPalette.gilded,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'RECAP',
                style: TextStyle(
                  color: MosaicPlumPalette.inkwell,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Mosaic Plum - End of Tour',
              style: TextStyle(
                color: MosaicPlumPalette.pearl,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'You explored twelve sections covering the anatomy, properties, '
          'live snapshots, header/footer slots, builder constructor, '
          'index semantics, proxyDecorator, do/avoid rules, canonical '
          'recipes, and glossary of ReorderableListView. Treat unique '
          'keys and the off-by-one rule as non-negotiable foundations.',
          style: TextStyle(
            color: MosaicPlumPalette.frostedLavender.withValues(alpha: 0.95),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            buildFooterChip('keys'),
            buildFooterChip('onReorder'),
            buildFooterChip('proxyDecorator'),
            buildFooterChip('header'),
            buildFooterChip('footer'),
            buildFooterChip('builder'),
            buildFooterChip('horizontal'),
            buildFooterChip('off-by-one'),
          ],
        ),
      ],
    ),
  );
}

Widget buildFooterChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.pearl.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: MosaicPlumPalette.gilded.withValues(alpha: 0.55),
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: MosaicPlumPalette.pearl,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section header helper.
// ----------------------------------------------------------------------------
Widget buildSectionHeader(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: MosaicPlumPalette.deepPlum,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: MosaicPlumPalette.gilded,
        width: 1.3,
      ),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: MosaicPlumPalette.gilded,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        fontSize: 14,
      ),
    ),
  );
}

// ============================================================================
// END OF FILE - Mosaic Plum ReorderableListView Demo
// ----------------------------------------------------------------------------
// Twelve sections, fourteen palette swatches, four live snapshots, one
// builder showcase, one header/footer showcase, one proxyDecorator showcase,
// ten DO/AVOID callouts, five recipe code cards, and a fifteen-term glossary.
// All ReorderableListView instances are rendered inside fixed-height SizedBox
// containers so they fit cleanly inside the outer SingleChildScrollView and
// every direct child carries a unique ValueKey<String>.
// ============================================================================
