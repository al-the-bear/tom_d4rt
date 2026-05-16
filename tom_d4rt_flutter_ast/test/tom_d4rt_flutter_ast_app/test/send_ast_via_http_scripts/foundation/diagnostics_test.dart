// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - Diagnostics Tree Lab
// Theme: A laboratory tour of Flutter's foundation diagnostics surface.
// Each section is a "specimen drawer" that examines one diagnostics primitive
// (StringProperty, IntProperty, DoubleProperty, EnumProperty, FlagProperty,
// IterableProperty, ObjectFlagProperty, DiagnosticsTreeStyle, DiagnosticLevel,
// DiagnosticsBlock, DiagnosticableTree). Diagnostics output is rendered as
// styled monospace tree visualisations — the strings are hand-synthesised so
// the layout matches what `toStringDeep` typically produces, without depending
// on actual runtime dumps.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================================
  // PALETTE — laboratory glass + ink scheme
  // ============================================================================

  const inkBlack = Color(0xFF0B1020);
  const inkSlate = Color(0xFF1B2233);
  const inkParchment = Color(0xFFF4F1E8);
  const inkAmber = Color(0xFFFFB300);
  const inkTeal = Color(0xFF00B8A9);
  const inkCoral = Color(0xFFFF6F61);
  const inkLavender = Color(0xFF9B7EDE);
  const inkMint = Color(0xFFA8E6CF);
  const inkClay = Color(0xFFD7CEC7);
  const inkRust = Color(0xFFB7410E);
  const inkOcean = Color(0xFF1F6FEB);
  const inkForest = Color(0xFF2E7D32);

  // ============================================================================
  // SECTION 1: DIAGNOSTICS PRIMITIVES — the periodic table of properties
  // ============================================================================

  final primitives = <Map<String, dynamic>>[
    {
      'symbol': 'Str',
      'name': 'StringProperty',
      'role': 'Wraps a String? — quoting & null handling',
      'inherits': 'DiagnosticsProperty<String>',
      'palette': inkTeal,
      'family': 'Scalar',
    },
    {
      'symbol': 'Int',
      'name': 'IntProperty',
      'role': 'Wraps an int? — integer rendering',
      'inherits': '_NumProperty<int>',
      'palette': inkOcean,
      'family': 'Scalar',
    },
    {
      'symbol': 'Dbl',
      'name': 'DoubleProperty',
      'role': 'Wraps a double? — fixed/exp formatting',
      'inherits': '_NumProperty<double>',
      'palette': inkLavender,
      'family': 'Scalar',
    },
    {
      'symbol': 'Enm',
      'name': 'EnumProperty<T>',
      'role': 'Wraps an enum value — short name printed',
      'inherits': 'DiagnosticsProperty<T>',
      'palette': inkAmber,
      'family': 'Scalar',
    },
    {
      'symbol': 'Flg',
      'name': 'FlagProperty',
      'role': 'Boolean with ifTrue / ifFalse legends',
      'inherits': 'DiagnosticsProperty<bool>',
      'palette': inkCoral,
      'family': 'Boolean',
    },
    {
      'symbol': 'Itr',
      'name': 'IterableProperty<T>',
      'role': 'Wraps an Iterable — element-by-element',
      'inherits': 'DiagnosticsProperty<Iterable<T>>',
      'palette': inkMint,
      'family': 'Collection',
    },
    {
      'symbol': 'Obj',
      'name': 'ObjectFlagProperty<T>',
      'role': 'Existence flag on any object',
      'inherits': 'DiagnosticsProperty<T>',
      'palette': inkRust,
      'family': 'Boolean',
    },
    {
      'symbol': 'Prp',
      'name': 'DiagnosticsProperty<T>',
      'role': 'Generic property root',
      'inherits': 'DiagnosticsNode',
      'palette': inkForest,
      'family': 'Generic',
    },
    {
      'symbol': 'Msg',
      'name': 'DiagnosticsNode.message',
      'role': 'Free-text node (no value)',
      'inherits': 'DiagnosticsNode',
      'palette': inkClay,
      'family': 'Message',
    },
    {
      'symbol': 'Blk',
      'name': 'DiagnosticsBlock',
      'role': 'Named children container',
      'inherits': 'DiagnosticsNode',
      'palette': inkLavender,
      'family': 'Container',
    },
  ];

  // ============================================================================
  // SECTION 2: STRING PROPERTY SCENARIOS — quoting register
  // ============================================================================

  final stringScenarios = <Map<String, dynamic>>[
    {
      'title': 'plain quoted',
      'snippet': 'StringProperty("label", "Hello")',
      'output': 'label: "Hello"',
      'note': 'default quoted=true wraps the value in quotes',
    },
    {
      'title': 'unquoted',
      'snippet': 'StringProperty("label", "Hello", quoted: false)',
      'output': 'label: Hello',
      'note': 'quoted:false omits the surrounding quotes',
    },
    {
      'title': 'null with defaultValue',
      'snippet':
          'StringProperty("subtitle", null, defaultValue: "untitled")',
      'output': 'subtitle: null (default: "untitled")',
      'note': 'null collapses to a sentinel and reports default',
    },
    {
      'title': 'showName=false',
      'snippet': 'StringProperty("text", "Click me", showName: false)',
      'output': '"Click me"',
      'note': 'name hidden when role is obvious from context',
    },
    {
      'title': 'ifEmpty',
      'snippet':
          'StringProperty("body", "", ifEmpty: "<empty>")',
      'output': 'body: <empty>',
      'note': 'empty string replaced by ifEmpty placeholder',
    },
    {
      'title': 'multiline',
      'snippet': 'StringProperty("doc", "line1\\nline2", quoted: false)',
      'output': 'doc: line1↵line2',
      'note': 'newlines preserved (↵ shown here as glyph)',
    },
  ];

  // ============================================================================
  // SECTION 3: NUMERIC PROPERTIES — int + double catalogue
  // ============================================================================

  final intScenarios = <Map<String, dynamic>>[
    {
      'title': 'plain int',
      'snippet': 'IntProperty("width", 200)',
      'output': 'width: 200',
    },
    {
      'title': 'with unit',
      'snippet': 'IntProperty("limit", 80, unit: "chars")',
      'output': 'limit: 80 chars',
    },
    {
      'title': 'null value',
      'snippet': 'IntProperty("count", null)',
      'output': 'count: null',
    },
    {
      'title': 'with defaultValue',
      'snippet': 'IntProperty("retries", 3, defaultValue: 0)',
      'output': 'retries: 3',
    },
    {
      'title': 'matches default → hidden',
      'snippet': 'IntProperty("retries", 0, defaultValue: 0)',
      'output': '(omitted at level fine)',
    },
  ];

  final doubleScenarios = <Map<String, dynamic>>[
    {
      'title': 'plain double',
      'snippet': 'DoubleProperty("opacity", 0.5)',
      'output': 'opacity: 0.5',
    },
    {
      'title': 'with unit',
      'snippet': 'DoubleProperty("padding", 16.0, unit: "px")',
      'output': 'padding: 16.0 px',
    },
    {
      'title': 'lazy supplier',
      'snippet': 'DoubleProperty.lazy("pct", () => 0.85)',
      'output': 'pct: 0.85',
    },
    {
      'title': 'with defaultValue',
      'snippet':
          'DoubleProperty("opacity", 1.0, defaultValue: 1.0)',
      'output': '(omitted at level fine)',
    },
    {
      'title': 'infinite',
      'snippet': 'DoubleProperty("limit", double.infinity)',
      'output': 'limit: Infinity',
    },
  ];

  // ============================================================================
  // SECTION 4: ENUM PROPERTY ATLAS — short-name printing
  // ============================================================================

  final enumScenarios = <Map<String, dynamic>>[
    {
      'title': 'TextAlign',
      'snippet': 'EnumProperty<TextAlign>("align", TextAlign.center)',
      'output': 'align: center',
      'family': 'paint/text',
    },
    {
      'title': 'TextDirection',
      'snippet':
          'EnumProperty<TextDirection>("dir", TextDirection.ltr)',
      'output': 'dir: ltr',
      'family': 'paint/text',
    },
    {
      'title': 'Axis',
      'snippet': 'EnumProperty<Axis>("axis", Axis.vertical)',
      'output': 'axis: vertical',
      'family': 'layout',
    },
    {
      'title': 'Brightness',
      'snippet':
          'EnumProperty<Brightness>("brightness", Brightness.dark)',
      'output': 'brightness: dark',
      'family': 'theming',
    },
    {
      'title': 'null EnumProperty',
      'snippet': 'EnumProperty<TextAlign>("align", null)',
      'output': 'align: null',
      'family': 'edge case',
    },
    {
      'title': 'with defaultValue (hidden)',
      'snippet':
          'EnumProperty<Axis>("axis", Axis.vertical, defaultValue: Axis.vertical)',
      'output': '(omitted — equals default)',
      'family': 'edge case',
    },
  ];

  // ============================================================================
  // SECTION 5: FLAG PROPERTY MOSAIC — true/false legends
  // ============================================================================

  final flagScenarios = <Map<String, dynamic>>[
    {
      'title': 'visible / hidden',
      'snippet':
          'FlagProperty("visible", value: true, ifTrue: "visible", ifFalse: "hidden")',
      'output': 'visible',
      'note': 'only the legend is printed, not the name',
    },
    {
      'title': 'visible / hidden (false)',
      'snippet':
          'FlagProperty("visible", value: false, ifTrue: "visible", ifFalse: "hidden")',
      'output': 'hidden',
      'note': 'false branch resolves to ifFalse',
    },
    {
      'title': 'enabled / disabled',
      'snippet':
          'FlagProperty("enabled", value: true, ifTrue: "enabled", ifFalse: "disabled")',
      'output': 'enabled',
      'note': 'symmetrical legend pair',
    },
    {
      'title': 'no ifFalse → silent',
      'snippet':
          'FlagProperty("dirty", value: false, ifTrue: "dirty")',
      'output': '(omitted)',
      'note': 'no legend for false → property silently dropped',
    },
    {
      'title': 'showName=true',
      'snippet':
          'FlagProperty("checked", value: true, ifTrue: "yes", showName: true)',
      'output': 'checked: yes',
      'note': 'showName toggles inclusion of the property name',
    },
  ];

  // ============================================================================
  // SECTION 6: ITERABLE PROPERTY — collection rendering
  // ============================================================================

  final iterableScenarios = <Map<String, dynamic>>[
    {
      'title': 'small list',
      'snippet':
          'IterableProperty<int>("offsets", [1, 2, 3])',
      'output': 'offsets: 1, 2, 3',
    },
    {
      'title': 'empty iterable',
      'snippet': 'IterableProperty<int>("offsets", const [])',
      'output': 'offsets: []',
    },
    {
      'title': 'null',
      'snippet': 'IterableProperty<int>("offsets", null)',
      'output': 'offsets: null',
    },
    {
      'title': 'long → truncated',
      'snippet':
          'IterableProperty<int>("ids", List<int>.generate(50, (i) => i))',
      'output': 'ids: 0, 1, 2, 3, ..., 47, 48, 49',
    },
    {
      'title': 'strings',
      'snippet':
          'IterableProperty<String>("tags", ["alpha", "beta"])',
      'output': 'tags: "alpha", "beta"',
    },
  ];

  // ============================================================================
  // SECTION 7: OBJECT FLAG PROPERTY — existence sentinels
  // ============================================================================

  final objectFlagScenarios = <Map<String, dynamic>>[
    {
      'title': 'callback present',
      'snippet':
          'ObjectFlagProperty<VoidCallback>.has("onTap", () {})',
      'output': 'has onTap',
      'note': 'shows "has X" when value != null',
    },
    {
      'title': 'callback missing',
      'snippet':
          'ObjectFlagProperty<VoidCallback>.has("onTap", null)',
      'output': 'no onTap',
      'note': 'shows "no X" when value == null',
    },
    {
      'title': 'custom ifPresent',
      'snippet':
          'ObjectFlagProperty<Listenable>("controller", obj, ifPresent: "wired")',
      'output': 'wired',
    },
    {
      'title': 'custom ifNull',
      'snippet':
          'ObjectFlagProperty<Listenable>("controller", null, ifNull: "detached")',
      'output': 'detached',
    },
    {
      'title': 'has + ifNull',
      'snippet':
          'ObjectFlagProperty<Object>("key", null, ifPresent: "has key", ifNull: "auto-key")',
      'output': 'auto-key',
    },
  ];

  // ============================================================================
  // SECTION 8: DIAGNOSTIC LEVEL ATLAS — filtering register
  // ============================================================================

  final levels = <Map<String, dynamic>>[
    {
      'name': 'hidden',
      'rank': 0,
      'color': Color(0xFF607D8B),
      'glyph': '·',
      'desc':
          'Suppressed entirely. Used for properties that should never be shown unless explicitly requested.',
    },
    {
      'name': 'fine',
      'rank': 1,
      'color': inkClay,
      'glyph': '∘',
      'desc':
          'Verbose detail. Typically hidden in normal dumps; surfaced only when increasing the verbosity threshold.',
    },
    {
      'name': 'debug',
      'rank': 2,
      'color': inkOcean,
      'glyph': '◯',
      'desc':
          'Default diagnostic verbosity. Most properties live here.',
    },
    {
      'name': 'info',
      'rank': 3,
      'color': inkTeal,
      'glyph': '●',
      'desc':
          'Informational properties that should appear even when terseness is preferred.',
    },
    {
      'name': 'warning',
      'rank': 4,
      'color': inkAmber,
      'glyph': '▲',
      'desc':
          'Property indicates something unusual; printed with attention but is not a hard error.',
    },
    {
      'name': 'hint',
      'rank': 5,
      'color': inkLavender,
      'glyph': '✦',
      'desc':
          'A suggestion or guidance. Often used by error messages that want to direct the reader to a fix.',
    },
    {
      'name': 'summary',
      'rank': 6,
      'color': inkForest,
      'glyph': '▣',
      'desc':
          'High-priority short summary lines. Always emitted, used at the top of error blocks.',
    },
    {
      'name': 'error',
      'rank': 7,
      'color': inkCoral,
      'glyph': '✕',
      'desc':
          'Property describes a fault. Always visible, often the headline of the dump.',
    },
    {
      'name': 'off',
      'rank': 8,
      'color': Color(0xFF455A64),
      'glyph': '∅',
      'desc':
          'A sentinel meaning "above any real level". Used to filter everything out.',
    },
  ];

  // ============================================================================
  // SECTION 9: DIAGNOSTICS TREE STYLE — punctuation variants
  // ============================================================================

  final styleSpecimens = <Map<String, dynamic>>[
    {
      'name': 'sparse',
      'desc':
          'Default style. Branch markers │ and ├── with a name colon between properties and children.',
      'output':
          'Container\n'
          ' │ color: Color(0xff00b8a9)\n'
          ' │ padding: EdgeInsets.all(8.0)\n'
          ' ├─child: Text\n'
          ' │   "Hello"\n'
          ' └─footer: SizedBox',
    },
    {
      'name': 'dense',
      'desc':
          'Compact style — no blank separators, less indentation. Used when many children are emitted.',
      'output':
          'Container\n'
          '│color: Color(0xff00b8a9)\n'
          '│padding: EdgeInsets.all(8.0)\n'
          '├─child: Text\n'
          '│ "Hello"\n'
          '└─footer: SizedBox',
    },
    {
      'name': 'box',
      'desc':
          'Used by RenderObject dumps. Heavy outline emphasises a container of properties + children.',
      'output':
          '╞═╦══ RenderFlex ═══════════\n'
          '│ ║ direction: vertical\n'
          '│ ║ mainAxisAlignment: start\n'
          '│ ╚═══════════════════════\n'
          '├─child 1: RenderParagraph\n'
          '└─child 2: RenderSizedBox',
    },
    {
      'name': 'shallow',
      'desc':
          'Children are summarised, not recursed. Used when only one level of structure is desired.',
      'output':
          'Container\n'
          ' │ color: Color(0xff00b8a9)\n'
          ' ├─child: Text(<Text>)\n'
          ' └─footer: SizedBox(<SizedBox>)',
    },
    {
      'name': 'singleLine',
      'desc':
          'Everything collapsed onto a single line. Useful for compact one-liners and tooltips.',
      'output':
          'Container(color: Color(0xff00b8a9), padding: EdgeInsets.all(8.0), child: Text("Hello"))',
    },
    {
      'name': 'errorProperty',
      'desc':
          'Used by FlutterError for the "summary" line of an error block; keeps trailing colon out.',
      'output':
          '══╡ EXCEPTION CAUGHT BY FRAMEWORK ╞══════════════════════════════\n'
          'The following assertion was thrown building MyWidget(dirty):',
    },
    {
      'name': 'whitespace',
      'desc':
          'No box/branch characters — pure indentation. Used by transcripts and JSON-like dumps.',
      'output':
          'Container\n'
          '  color: Color(0xff00b8a9)\n'
          '  padding: EdgeInsets.all(8.0)\n'
          '  child: Text\n'
          '    "Hello"',
    },
    {
      'name': 'flat',
      'desc':
          'Children are emitted without any indentation. Rare; used by inline error walks.',
      'output':
          'Container\n'
          'color: Color(0xff00b8a9)\n'
          'padding: EdgeInsets.all(8.0)\n'
          'child: Text\n'
          '"Hello"',
    },
  ];

  // ============================================================================
  // SECTION 10: DIAGNOSTICS NODE TREES — hand-synthesised dumps
  // ============================================================================

  final treeSpecimens = <Map<String, dynamic>>[
    {
      'title': 'Padding(Container(Text))',
      'palette': inkTeal,
      'tree':
          'Padding\n'
          ' │ padding: EdgeInsets.all(16.0)\n'
          ' └─child: Container\n'
          '     │ color: Color(0xff00b8a9)\n'
          '     │ alignment: center\n'
          '     └─child: Text\n'
          '         │ data: "Diagnostics Tree Lab"\n'
          '         │ textAlign: center\n'
          '         └─style: TextStyle(fontSize: 24.0)',
    },
    {
      'title': 'Row of three children',
      'palette': inkOcean,
      'tree':
          'Row\n'
          ' │ mainAxisAlignment: spaceBetween\n'
          ' │ crossAxisAlignment: center\n'
          ' ├─children[0]: Icon\n'
          ' │   │ icon: Icons.menu\n'
          ' │   │ size: 24.0\n'
          ' │   └─color: Color(0xff263238)\n'
          ' ├─children[1]: Text\n'
          ' │   │ data: "Header"\n'
          ' │   └─style: TextStyle(fontWeight: bold)\n'
          ' └─children[2]: Icon\n'
          '     │ icon: Icons.search\n'
          '     └─size: 24.0',
    },
    {
      'title': 'Column with FlagProperty',
      'palette': inkLavender,
      'tree':
          'Column\n'
          ' │ direction: vertical\n'
          ' │ mainAxisSize: max\n'
          ' │ visible\n'
          ' │ enabled\n'
          ' └─children: [\n'
          '     Text("alpha"),\n'
          '     Text("beta"),\n'
          '     Text("gamma"),\n'
          '   ]',
    },
    {
      'title': 'Stack with named children',
      'palette': inkRust,
      'tree':
          'Stack\n'
          ' │ alignment: topStart\n'
          ' │ fit: loose\n'
          ' ├─background: Positioned\n'
          ' │   │ left: 0.0\n'
          ' │   │ top: 0.0\n'
          ' │   └─child: ColoredBox(color: Color(0xfff4f1e8))\n'
          ' └─foreground: Align\n'
          '     │ alignment: center\n'
          '     └─child: Text("overlay")',
    },
    {
      'title': 'RenderFlex layout dump',
      'palette': inkCoral,
      'tree':
          'RenderFlex#a1b2c (relayoutBoundary=up3)\n'
          ' │ creator: Row ← Padding ← Center ← ...\n'
          ' │ parentData: offset=Offset(0.0, 0.0)\n'
          ' │ constraints: BoxConstraints(0.0<=w<=375.0, 0.0<=h<=Infinity)\n'
          ' │ size: Size(375.0, 56.0)\n'
          ' │ direction: horizontal\n'
          ' │ mainAxisAlignment: spaceBetween\n'
          ' │ crossAxisAlignment: center\n'
          ' │ textDirection: ltr\n'
          ' │ verticalDirection: down\n'
          ' ├─child 1: RenderParagraph#a1b2d\n'
          ' │   │ creator: Text ← Padding ← Row ← ...\n'
          ' │   │ size: Size(120.0, 24.0)\n'
          ' │   └─text: "Hello"\n'
          ' └─child 2: RenderConstrainedBox#a1b2e\n'
          '     │ creator: SizedBox ← Row ← ...\n'
          '     └─size: Size(48.0, 48.0)',
    },
    {
      'title': 'Error-style summary block',
      'palette': inkAmber,
      'tree':
          '══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞════════════════════\n'
          'The following assertion was thrown building MyWidget(dirty):\n'
          'A non-null String must be provided to a Text widget.\n'
          '\n'
          'The relevant error-causing widget was:\n'
          '  MyWidget MyWidget:file:///lib/main.dart:42:7\n'
          '\n'
          'When the exception was thrown, this was the stack:\n'
          '  #0  new Text (package:flutter/src/widgets/text.dart:412:10)\n'
          '  #1  MyWidget.build (package:demo/main.dart:48:12)\n'
          '════════════════════════════════════════════════════════════',
    },
  ];

  // ============================================================================
  // SECTION 11: DIAGNOSTICS BLOCK — named child container
  // ============================================================================

  final blockSpecimens = <Map<String, dynamic>>[
    {
      'title': 'AssertionBlock',
      'palette': inkCoral,
      'block':
          '┌─ Failing assertion\n'
          '│   message: child cannot be null\n'
          '│   library: widgets\n'
          '│   line: 412\n'
          '└─ end of assertion',
    },
    {
      'title': 'StackBlock',
      'palette': inkOcean,
      'block':
          '┌─ stack trace (truncated)\n'
          '│   #0  new Text (text.dart:412:10)\n'
          '│   #1  MyWidget.build (main.dart:48:12)\n'
          '│   #2  StatelessElement.build (framework.dart:5072:28)\n'
          '│   #3  ComponentElement.performRebuild (framework.dart:5005:15)\n'
          '└─ end of stack',
    },
    {
      'title': 'ContextBlock',
      'palette': inkLavender,
      'block':
          '┌─ build context\n'
          '│   widget: MyWidget\n'
          '│   element: StatelessElement#42\n'
          '│   parent: Padding\n'
          '│   depth: 12\n'
          '└─ end of context',
    },
    {
      'title': 'PropertiesBlock',
      'palette': inkTeal,
      'block':
          '┌─ properties\n'
          '│   ● label: "Submit"\n'
          '│   ● enabled\n'
          '│   ● color: Color(0xff1f6feb)\n'
          '│   ● padding: EdgeInsets.all(12.0)\n'
          '└─ end of properties',
    },
  ];

  // ============================================================================
  // SECTION 12: REAL-WORLD-STYLE DUMPS — Widget / Element / RenderObject
  // ============================================================================

  final realWorldDumps = <Map<String, dynamic>>[
    {
      'title': 'Widget tree (toStringDeep)',
      'palette': inkTeal,
      'dump':
          'MaterialApp\n'
          ' │ title: "Diagnostics Lab"\n'
          ' │ theme: ThemeData(brightness: light)\n'
          ' └─home: Scaffold\n'
          '     │ backgroundColor: Color(0xfff4f1e8)\n'
          '     ├─appBar: AppBar\n'
          '     │   │ title: Text("Lab")\n'
          '     │   └─elevation: 0.0\n'
          '     └─body: SingleChildScrollView\n'
          '         └─child: Column\n'
          '             │ direction: vertical\n'
          '             └─children: [Header, Sections, Footer]',
    },
    {
      'title': 'Element tree (toStringDeep)',
      'palette': inkOcean,
      'dump':
          'StatefulElement#a1b2c(MaterialApp)\n'
          ' │ widget: MaterialApp\n'
          ' │ state: _MaterialAppState#d4e5f\n'
          ' │ dirty: false\n'
          ' └─child: StatelessElement#1234(WidgetsApp)\n'
          '     │ widget: WidgetsApp\n'
          '     └─child: StatefulElement#5678(Navigator)\n'
          '         │ widget: Navigator\n'
          '         └─child: StatelessElement#9abc(Scaffold)\n'
          '             │ widget: Scaffold\n'
          '             └─child: ...',
    },
    {
      'title': 'RenderObject tree (toStringDeep)',
      'palette': inkLavender,
      'dump':
          'RenderView#root\n'
          ' │ window size: Size(375.0, 812.0)\n'
          ' │ device pixel ratio: 3.0\n'
          ' └─child: RenderRepaintBoundary#0\n'
          '     │ size: Size(375.0, 812.0)\n'
          '     └─child: RenderCustomPaint#1\n'
          '         │ size: Size(375.0, 812.0)\n'
          '         └─child: RenderPositionedBox#2\n'
          '             │ alignment: center\n'
          '             │ size: Size(375.0, 812.0)\n'
          '             └─child: RenderConstrainedBox#3\n'
          '                 │ additionalConstraints: BoxConstraints(w=375.0)\n'
          '                 └─size: Size(375.0, 800.0)',
    },
    {
      'title': 'Semantics tree (toStringDeep)',
      'palette': inkAmber,
      'dump':
          'SemanticsNode#0 (rect: Rect.fromLTRB(0.0, 0.0, 375.0, 812.0))\n'
          ' │ flags: isFocusable, isButton\n'
          ' │ label: "Submit"\n'
          ' └─child SemanticsNode#1 (rect: Rect.fromLTRB(0.0, 56.0, 375.0, 800.0))\n'
          '     │ flags: scopesRoute, namesRoute\n'
          '     ├─SemanticsNode#2 label="Header"\n'
          '     ├─SemanticsNode#3 label="Body"\n'
          '     └─SemanticsNode#4 label="Footer"',
    },
  ];

  // ============================================================================
  // SECTION 13: GLOSSARY — terms for the tour
  // ============================================================================

  final glossary = <Map<String, String>>[
    {
      'term': 'DiagnosticsNode',
      'def':
          'Abstract base of every node in a diagnostics tree. Carries name, value, style, level, and children/properties.',
    },
    {
      'term': 'DiagnosticableTree',
      'def':
          'Mixin/class declaring `debugFillProperties` and `debugDescribeChildren` for hierarchical dumps.',
    },
    {
      'term': 'DiagnosticPropertiesBuilder',
      'def':
          'Accumulator passed into `debugFillProperties`; gathers properties to be rendered.',
    },
    {
      'term': 'DiagnosticsProperty<T>',
      'def':
          'Generic, typed leaf node — the parent class of most concrete property types.',
    },
    {
      'term': 'DiagnosticsTreeStyle',
      'def':
          'Enum selecting punctuation/indentation for a node. Inherited or set explicitly.',
    },
    {
      'term': 'DiagnosticLevel',
      'def':
          'Filtering knob — determines whether a node appears at a given verbosity threshold.',
    },
    {
      'term': 'DiagnosticsBlock',
      'def':
          'A named container that groups children inside a box-style frame; used by error messages.',
    },
    {
      'term': 'toStringDeep',
      'def':
          'Produces a recursive textual rendering of a Diagnosticable subtree.',
    },
    {
      'term': 'toStringShallow',
      'def':
          'Single-node textual rendering — properties only, no children recursed.',
    },
    {
      'term': 'value vs description',
      'def':
          'A property has a real Dart `value` and a textual `description`; the description honours the style.',
    },
  ];

  // ============================================================================
  // SECTION 14: COMPARISON TABLE DATA
  // ============================================================================

  final levelTableRows = <List<String>>[
    ['hidden', '0', 'silent', 'never printed'],
    ['fine', '1', 'verbose', 'verbose dumps only'],
    ['debug', '2', 'normal', 'standard verbosity'],
    ['info', '3', 'inform', 'shown even when terse'],
    ['warning', '4', 'attention', 'unusual but not fatal'],
    ['hint', '5', 'guide', 'suggested fixes'],
    ['summary', '6', 'highlight', 'top of an error block'],
    ['error', '7', 'fault', 'always visible'],
    ['off', '8', 'sentinel', 'filters everything out'],
  ];

  final styleTableRows = <List<String>>[
    ['sparse', 'default', '│ ├── └──', 'most common'],
    ['dense', 'compact', '│├─└─', 'crowded dumps'],
    ['box', 'framed', '╔═╞╞══╝', 'RenderObject dumps'],
    ['shallow', 'summary', '│ ├── └──', 'one-level only'],
    ['singleLine', 'inline', '(no markers)', 'tooltips'],
    ['errorProperty', 'header', '══╡ … ╞══', 'error summaries'],
    ['whitespace', 'indent', '(spaces only)', 'JSON-style logs'],
    ['flat', 'flat', '(no indent)', 'compact walk'],
  ];

  // ============================================================================
  // SECTION 15: WIDGET BUILDERS
  // ============================================================================

  return MaterialApp(
    title: 'Diagnostics Tree Lab',
    home: Scaffold(
      backgroundColor: inkParchment,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heroBanner(inkBlack, inkSlate, inkAmber, inkTeal),
            _sectionHeader(
              '1',
              'Diagnostics Primitives — the periodic table',
              inkBlack,
              inkAmber,
            ),
            _primitiveGrid(primitives, inkBlack),
            _recipeCard(
              'Adding a primitive',
              'builder.add(StringProperty("name", value));',
              inkSlate,
              inkParchment,
              inkAmber,
            ),
            _sectionHeader(
              '2',
              'StringProperty Scenarios — quoting register',
              inkBlack,
              inkTeal,
            ),
            _scenarioGrid(stringScenarios, inkTeal, inkBlack),
            _recipeCard(
              'Quoting & null handling',
              'StringProperty("label", value,\n'
                  '  quoted: true,\n'
                  '  defaultValue: "<auto>",\n'
                  '  ifEmpty: "<empty>",\n'
                  ');',
              inkSlate,
              inkParchment,
              inkTeal,
            ),
            _sectionHeader(
              '3',
              'IntProperty & DoubleProperty — numeric register',
              inkBlack,
              inkOcean,
            ),
            _numericRow(
              'IntProperty',
              intScenarios,
              inkOcean,
              inkBlack,
            ),
            _numericRow(
              'DoubleProperty',
              doubleScenarios,
              inkLavender,
              inkBlack,
            ),
            _recipeCard(
              'IntProperty with unit',
              'IntProperty("limit", 80, unit: "chars");',
              inkSlate,
              inkParchment,
              inkOcean,
            ),
            _recipeCard(
              'Lazy DoubleProperty',
              'DoubleProperty.lazy("pct", () => computeRatio());',
              inkSlate,
              inkParchment,
              inkLavender,
            ),
            _sectionHeader(
              '4',
              'EnumProperty Atlas — short names',
              inkBlack,
              inkAmber,
            ),
            _scenarioGrid(enumScenarios, inkAmber, inkBlack),
            _recipeCard(
              'EnumProperty<T>',
              'EnumProperty<TextAlign>(\n'
                  '  "align",\n'
                  '  TextAlign.center,\n'
                  '  defaultValue: TextAlign.start,\n'
                  ');',
              inkSlate,
              inkParchment,
              inkAmber,
            ),
            _sectionHeader(
              '5',
              'FlagProperty Mosaic — legend pairs',
              inkBlack,
              inkCoral,
            ),
            _flagGrid(flagScenarios, inkCoral, inkBlack),
            _recipeCard(
              'FlagProperty with legends',
              'FlagProperty(\n'
                  '  "visible",\n'
                  '  value: isVisible,\n'
                  '  ifTrue: "visible",\n'
                  '  ifFalse: "hidden",\n'
                  ');',
              inkSlate,
              inkParchment,
              inkCoral,
            ),
            _sectionHeader(
              '6',
              'IterableProperty — collection rendering',
              inkBlack,
              inkMint,
            ),
            _scenarioGrid(iterableScenarios, inkMint, inkBlack),
            _recipeCard(
              'IterableProperty<T>',
              'IterableProperty<int>(\n'
                  '  "offsets",\n'
                  '  offsets,\n'
                  '  defaultValue: const <int>[],\n'
                  ');',
              inkSlate,
              inkParchment,
              inkMint,
            ),
            _sectionHeader(
              '7',
              'ObjectFlagProperty — existence sentinels',
              inkBlack,
              inkRust,
            ),
            _scenarioGrid(objectFlagScenarios, inkRust, inkBlack),
            _recipeCard(
              'ObjectFlagProperty.has',
              'ObjectFlagProperty<VoidCallback>.has(\n'
                  '  "onTap",\n'
                  '  onTap,\n'
                  ');',
              inkSlate,
              inkParchment,
              inkRust,
            ),
            _sectionHeader(
              '8',
              'DiagnosticLevel Atlas — filtering register',
              inkBlack,
              inkLavender,
            ),
            _levelMatrix(levels, inkBlack),
            _levelTable(levelTableRows, inkBlack, inkLavender),
            _sectionHeader(
              '9',
              'DiagnosticsTreeStyle Variants',
              inkBlack,
              inkOcean,
            ),
            _styleGrid(styleSpecimens, inkOcean, inkBlack),
            _styleTable(styleTableRows, inkBlack, inkOcean),
            _sectionHeader(
              '10',
              'DiagnosticsNode Trees — hand-synthesised dumps',
              inkBlack,
              inkTeal,
            ),
            _treeGrid(treeSpecimens, inkBlack),
            _sectionHeader(
              '11',
              'DiagnosticsBlock — named child containers',
              inkBlack,
              inkCoral,
            ),
            _blockGrid(blockSpecimens, inkBlack),
            _sectionHeader(
              '12',
              'Real-world Dumps — Widget/Element/Render/Semantics',
              inkBlack,
              inkAmber,
            ),
            _realWorldGrid(realWorldDumps, inkBlack),
            _sectionHeader(
              '13',
              'Glossary',
              inkBlack,
              inkForest,
            ),
            _glossaryList(glossary, inkBlack, inkForest),
            _sectionHeader(
              '14',
              'Epilogue — closing notes',
              inkBlack,
              inkSlate,
            ),
            _epilogue(inkSlate, inkParchment, inkAmber),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPER: hero banner
// ============================================================================

Widget _heroBanner(
  Color inkBlack,
  Color inkSlate,
  Color inkAmber,
  Color inkTeal,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [inkBlack, inkSlate, Color(0xFF263238)],
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: inkAmber,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'FOUNDATION · DIAGNOSTICS',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: inkBlack,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: inkTeal,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'TREE LAB',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1020),
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'Diagnostics Tree Lab',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF4F1E8),
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A guided tour of DiagnosticsNode · DiagnosticsProperty · '
          'TreeStyle · Level · Block.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFFD7CEC7),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _heroChip('11 sections', inkAmber, inkBlack),
            SizedBox(width: 8.0),
            _heroChip('40+ cards', inkTeal, inkBlack),
            SizedBox(width: 8.0),
            _heroChip('Mono-tree visuals', Color(0xFFFFFFFF), inkBlack),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label, Color bg, Color text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 11.0, color: text, fontWeight: FontWeight.bold),
    ),
  );
}

// ============================================================================
// HELPER: section header
// ============================================================================

Widget _sectionHeader(
  String number,
  String title,
  Color inkBlack,
  Color accent,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: inkBlack,
              ),
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: inkBlack,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: primitive grid
// ============================================================================

Widget _primitiveGrid(List<Map<String, dynamic>> primitives, Color inkBlack) {
  final cards = <Widget>[];
  for (final p in primitives) {
    cards.add(_primitiveCard(p, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    ),
  );
}

Widget _primitiveCard(Map<String, dynamic> p, Color inkBlack) {
  final palette = p['palette'] as Color;
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: palette, width: 5.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: palette,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                p['symbol'].toString(),
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                p['family'].toString(),
                style: TextStyle(
                  fontSize: 10.0,
                  color: Color(0xFF607D8B),
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          p['name'].toString(),
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: inkBlack,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          p['role'].toString(),
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF455A64),
            height: 1.4,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'extends ${p['inherits']}',
          style: TextStyle(
            fontSize: 10.0,
            color: palette,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: recipe card (monospace source snippet)
// ============================================================================

Widget _recipeCard(
  String title,
  String snippet,
  Color bg,
  Color fg,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: accent, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'RECIPE',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: bg,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: fg,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          snippet,
          style: TextStyle(
            fontSize: 12.0,
            color: fg,
            fontFamily: 'monospace',
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: scenario grid (used by several sections)
// ============================================================================

Widget _scenarioGrid(
  List<Map<String, dynamic>> scenarios,
  Color accent,
  Color inkBlack,
) {
  final cards = <Widget>[];
  for (final s in scenarios) {
    cards.add(_scenarioCard(s, accent, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    ),
  );
}

Widget _scenarioCard(
  Map<String, dynamic> s,
  Color accent,
  Color inkBlack,
) {
  return Container(
    width: 320.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                s['title'].toString(),
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: inkBlack,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6.0),
            border: Border(left: BorderSide(color: accent, width: 3.0)),
          ),
          child: Text(
            s['snippet'].toString(),
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF263238),
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            s['output'].toString(),
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFA8E6CF),
              height: 1.45,
            ),
          ),
        ),
        if (s.containsKey('note')) ...[
          SizedBox(height: 6.0),
          Text(
            s['note'].toString(),
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF607D8B),
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
        if (s.containsKey('family')) ...[
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              s['family'].toString(),
              style: TextStyle(
                fontSize: 9.0,
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

// ============================================================================
// HELPER: numeric row (Int/Double labelled blocks)
// ============================================================================

Widget _numericRow(
  String label,
  List<Map<String, dynamic>> scenarios,
  Color accent,
  Color inkBlack,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(top: BorderSide(color: accent, width: 4.0)),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              'scenario register',
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF607D8B),
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            for (final s in scenarios)
              _numericCell(s, accent, inkBlack),
          ],
        ),
      ],
    ),
  );
}

Widget _numericCell(
  Map<String, dynamic> s,
  Color accent,
  Color inkBlack,
) {
  return Container(
    width: 280.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s['title'].toString(),
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: inkBlack,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          s['snippet'].toString(),
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: Color(0xFF263238),
            height: 1.4,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Color(0xFF0B1020),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            s['output'].toString(),
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFFFFB300),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: flag grid
// ============================================================================

Widget _flagGrid(
  List<Map<String, dynamic>> flags,
  Color accent,
  Color inkBlack,
) {
  final cards = <Widget>[];
  for (final f in flags) {
    cards.add(_flagCard(f, accent, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    ),
  );
}

Widget _flagCard(
  Map<String, dynamic> f,
  Color accent,
  Color inkBlack,
) {
  return Container(
    width: 340.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'FLAG',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.8,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                f['title'].toString(),
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: inkBlack,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAF7F0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            f['snippet'].toString(),
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF263238),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Color(0xFF0B1020),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '> ${f['output']}',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          f['note'].toString(),
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF607D8B),
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: level matrix
// ============================================================================

Widget _levelMatrix(List<Map<String, dynamic>> levels, Color inkBlack) {
  final cards = <Widget>[];
  for (final l in levels) {
    cards.add(_levelCard(l, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: cards,
    ),
  );
}

Widget _levelCard(Map<String, dynamic> l, Color inkBlack) {
  final color = l['color'] as Color;
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  l['glyph'].toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l['name'].toString(),
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: inkBlack,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'rank ${l['rank']}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          l['desc'].toString(),
          style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF455A64),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _levelTable(
  List<List<String>> rows,
  Color inkBlack,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              _tableHead('level', 110.0),
              _tableHead('rank', 60.0),
              _tableHead('role', 110.0),
              Expanded(child: _tableHead('meaning', 0.0)),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: i.isEven ? Color(0xFFF7F8FA) : Color(0xFFFFFFFF),
            ),
            child: Row(
              children: [
                _tableCell(rows[i][0], 110.0, inkBlack, mono: true),
                _tableCell(rows[i][1], 60.0, inkBlack, mono: true),
                _tableCell(rows[i][2], 110.0, inkBlack),
                Expanded(child: _tableCell(rows[i][3], 0.0, inkBlack)),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _tableHead(String label, double width) {
  return SizedBox(
    width: width == 0.0 ? null : width,
    child: Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 10.0,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _tableCell(
  String value,
  double width,
  Color inkBlack, {
  bool mono = false,
}) {
  return SizedBox(
    width: width == 0.0 ? null : width,
    child: Text(
      value,
      style: TextStyle(
        fontSize: 12.0,
        color: inkBlack,
        fontFamily: mono ? 'monospace' : null,
      ),
    ),
  );
}

// ============================================================================
// HELPER: style grid (DiagnosticsTreeStyle specimens)
// ============================================================================

Widget _styleGrid(
  List<Map<String, dynamic>> styles,
  Color accent,
  Color inkBlack,
) {
  final cards = <Widget>[];
  for (final s in styles) {
    cards.add(_styleCard(s, accent, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    ),
  );
}

Widget _styleCard(
  Map<String, dynamic> s,
  Color accent,
  Color inkBlack,
) {
  return Container(
    width: 460.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                s['name'].toString(),
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'DiagnosticsTreeStyle.${s['name']}',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Color(0xFF607D8B),
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          s['desc'].toString(),
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF455A64),
            height: 1.45,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF0B1020),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            s['output'].toString(),
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFA8E6CF),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _styleTable(
  List<List<String>> rows,
  Color inkBlack,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.3), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              _tableHead('style', 130.0),
              _tableHead('shape', 100.0),
              _tableHead('markers', 130.0),
              Expanded(child: _tableHead('used by', 0.0)),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: i.isEven ? Color(0xFFF7F8FA) : Color(0xFFFFFFFF),
            ),
            child: Row(
              children: [
                _tableCell(rows[i][0], 130.0, inkBlack, mono: true),
                _tableCell(rows[i][1], 100.0, inkBlack),
                _tableCell(rows[i][2], 130.0, inkBlack, mono: true),
                Expanded(child: _tableCell(rows[i][3], 0.0, inkBlack)),
              ],
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: tree grid (DiagnosticsNode trees)
// ============================================================================

Widget _treeGrid(List<Map<String, dynamic>> trees, Color inkBlack) {
  final cards = <Widget>[];
  for (final t in trees) {
    cards.add(_treeCard(t, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    ),
  );
}

Widget _treeCard(Map<String, dynamic> t, Color inkBlack) {
  final palette = t['palette'] as Color;
  return Container(
    width: 460.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        top: BorderSide(color: palette, width: 4.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: palette,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                t['title'].toString(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: inkBlack,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: palette.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'tree',
                style: TextStyle(
                  fontSize: 10.0,
                  color: palette,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF0B1020),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 5.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Text(
            t['tree'].toString(),
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: Color(0xFFD7CEC7),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: block grid (DiagnosticsBlock specimens)
// ============================================================================

Widget _blockGrid(List<Map<String, dynamic>> blocks, Color inkBlack) {
  final cards = <Widget>[];
  for (final b in blocks) {
    cards.add(_blockCard(b, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: cards,
    ),
  );
}

Widget _blockCard(Map<String, dynamic> b, Color inkBlack) {
  final palette = b['palette'] as Color;
  return Container(
    width: 440.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: palette.withOpacity(0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: palette,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'BLOCK',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 1.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                b['title'].toString(),
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: inkBlack,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1B2233),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            b['block'].toString(),
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: palette,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: real-world dump grid
// ============================================================================

Widget _realWorldGrid(List<Map<String, dynamic>> dumps, Color inkBlack) {
  final cards = <Widget>[];
  for (final d in dumps) {
    cards.add(_realWorldCard(d, inkBlack));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cards,
    ),
  );
}

Widget _realWorldCard(Map<String, dynamic> d, Color inkBlack) {
  final palette = d['palette'] as Color;
  return Container(
    margin: EdgeInsets.only(bottom: 12.0),
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      border: Border(left: BorderSide(color: palette, width: 5.0)),
      boxShadow: [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              d['title'].toString(),
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: inkBlack,
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: palette.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'real-world',
                style: TextStyle(
                  fontSize: 10.0,
                  color: palette,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFF0B1020),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            d['dump'].toString(),
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFA8E6CF),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: glossary list
// ============================================================================

Widget _glossaryList(
  List<Map<String, String>> entries,
  Color inkBlack,
  Color accent,
) {
  final items = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    items.add(_glossaryEntry(entries[i], i, inkBlack, accent));
  }
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}

Widget _glossaryEntry(
  Map<String, String> e,
  int index,
  Color inkBlack,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: index.isEven ? Color(0xFFFFFFFF) : Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          e['term']!,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: inkBlack,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          e['def']!,
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF455A64),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER: epilogue
// ============================================================================

Widget _epilogue(Color bg, Color fg, Color accent) {
  return Container(
    margin: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 32.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [bg, Color(0xFF263238)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'EPILOGUE',
            style: TextStyle(
              fontSize: 10.0,
              color: bg,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Diagnostics are the framework\'s lens on itself.',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: fg,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Every Diagnosticable subclass contributes named, typed nodes via '
          'debugFillProperties. Those nodes are leaves of a richer tree '
          'assembled by toDiagnosticsNode + debugDescribeChildren. The lab '
          'we just toured renders synthesised approximations of that tree — '
          'matching the punctuation, indentation, and styling that the real '
          'foundation produces. Use these specimens as a visual reference '
          'while reading actual toStringDeep dumps in your own apps.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFFD7CEC7),
            height: 1.6,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0x331F6FEB),
            borderRadius: BorderRadius.circular(8.0),
            border: Border(left: BorderSide(color: accent, width: 3.0)),
          ),
          child: Text(
            '✦  Tip: call obj.toStringDeep() in a debug-only logger to '
            'capture full subtree dumps. Wrap with debugPrint to avoid '
            'iOS log truncation.',
            style: TextStyle(
              fontSize: 12.0,
              color: fg,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}
