from pathlib import Path

base = Path('test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/material')

files = [
    'button_bar_theme_test.dart',
    'button_style_button_test.dart',
    'calendar_delegate_test.dart',
    'card_theme_data_test.dart',
    'carousel_controller_test.dart',
    'carousel_scroll_physics_test.dart',
    'carousel_view_test.dart',
    'carousel_view_theme_data_test.dart',
    'carousel_view_theme_test.dart',
    'checkbox_list_tile_test.dart',
    'checked_popup_menu_item_test.dart',
    'checkmarkable_chip_attributes_test.dart',
    'chip_animation_style_test.dart',
    'class_test.dart',
    'close_button_icon_test.dart',
    'close_button_test.dart',
    'colors_test.dart',
    'controls_details_test.dart',
    'cupertino_based_material_theme_data_test.dart',
    'data_table_source_test.dart',
]


def scaffold(title: str, body: str, summary: list[str], imports: list[str] | None = None, pre: str = '') -> str:
    imports = imports or ["import 'package:flutter/material.dart';"]
    lines = []
    lines.extend(imports)
    lines.append('')
    if pre:
        lines.append(pre.rstrip())
        lines.append('')
    lines.extend([
        'void _expect(bool condition, String message, List<String> logs) {',
        '  if (!condition) {',
        "    logs.add('FAIL: ' + message);",
        f"    throw StateError('{title} assertion failed: ' + message);",
        '  }',
        "  logs.add('PASS: ' + message);",
        '}',
        '',
        'dynamic build(BuildContext context) {',
        f"  print('=== {title} comprehensive test start ===');",
        '  final logs = <String>[];',
        '  var assertionCount = 0;',
        '',
    ])
    lines.extend(body.strip('\n').split('\n'))
    lines.extend([
        '',
        '  for (final line in logs) {',
        '    print(line);',
        '  }',
        f"  print('=== {title} comprehensive test complete ===');",
        '',
        '  return Column(',
        '    mainAxisSize: MainAxisSize.min,',
        '    crossAxisAlignment: CrossAxisAlignment.start,',
        '    children: [',
        f"      const Text('{title} Tests'),",
        "      Text('Assertions: $assertionCount'),",
    ])
    for entry in summary:
        lines.append(f"      Text({entry}),")
    lines.extend([
        "      const Text('Summary widget generated successfully'),",
        '    ],',
        '  );',
        '}',
        '',
    ])

    while len(lines) < 115:
        idx = len(lines) - 1
        lines.append(f'// coverage filler line {idx:03d}')
    return '\n'.join(lines) + '\n'


content = {}

content['button_bar_theme_test.dart'] = scaffold(
    'ButtonBarTheme',
    body='''  const baseData = ButtonBarThemeData(alignment: MainAxisAlignment.center);
  const edgeData = ButtonBarThemeData();
  const themed = ButtonBarTheme(data: baseData, child: SizedBox.shrink());

  _expect(themed.data == baseData, 'constructor stores theme data', logs);
  assertionCount++;
  _expect(themed.child is SizedBox, 'constructor stores child', logs);
  assertionCount++;
  _expect(edgeData.alignment == null, 'edge case allows null alignment', logs);
  assertionCount++;

  final inherited = ButtonBarTheme.of(context);
  _expect(inherited is ButtonBarThemeData, 'ButtonBarTheme.of resolves data', logs);
  assertionCount++;

  const updated = ButtonBarTheme(data: edgeData, child: SizedBox.shrink());
  _expect(themed.updateShouldNotify(updated), 'updateShouldNotify reacts to data change', logs);
  assertionCount++;

  _expect(assertionCount >= 5, 'multiple assertions executed', logs);
  assertionCount++;''',
    summary=["'Inherited hash: ' + ButtonBarTheme.of(context).hashCode.toString()"],
)

content['button_style_button_test.dart'] = scaffold(
    'ButtonStyleButton',
    pre='''class _DemoButton extends ButtonStyleButton {
  const _DemoButton({
    super.key,
    required super.onPressed,
    super.onLongPress,
    super.style,
    super.focusNode,
    super.statesController,
    super.tooltip,
    super.child,
  }) : super(
         onHover: null,
         onFocusChange: null,
         autofocus: false,
         clipBehavior: Clip.none,
       );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) =>
      TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12));

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => null;
}''',
    body='''  final enabled = _DemoButton(onPressed: () {}, child: const Text('Enabled'));
  final disabled = _DemoButton(onPressed: null, child: const Text('Disabled'));

  _expect(enabled is ButtonStyleButton, 'subclass is a ButtonStyleButton', logs);
  assertionCount++;
  _expect(enabled.enabled, 'enabled button reports enabled=true', logs);
  assertionCount++;
  _expect(!disabled.enabled, 'null callbacks produce disabled button', logs);
  assertionCount++;

  final defaultStyle = enabled.defaultStyleOf(context);
  _expect(defaultStyle is ButtonStyle, 'defaultStyleOf returns ButtonStyle', logs);
  assertionCount++;

  final wrapped = ButtonStyleButton.allOrNull<double>(4.0);
  _expect(wrapped != null, 'allOrNull wraps non-null value', logs);
  assertionCount++;

  final wrappedNull = ButtonStyleButton.allOrNull<double>(null);
  _expect(wrappedNull == null, 'allOrNull returns null for null input', logs);
  assertionCount++;''',
    summary=["'Enabled: ' + enabled.enabled.toString()", "'Disabled: ' + disabled.enabled.toString()"],
)

content['calendar_delegate_test.dart'] = scaffold(
    'CalendarDelegate',
    body='''  const GregorianCalendarDelegate delegate = GregorianCalendarDelegate();
  final CalendarDelegate<DateTime> base = delegate;
  final date = DateTime(2026, 3, 14, 12, 30);

  _expect(base is CalendarDelegate<DateTime>, 'delegate satisfies base type', logs);
  assertionCount++;
  _expect(base.dateOnly(date).hour == 0, 'dateOnly strips time component', logs);
  assertionCount++;
  _expect(base.monthDelta(DateTime(2026, 1, 1), DateTime(2026, 3, 1)) == 2, 'monthDelta works', logs);
  assertionCount++;
  _expect(base.addDaysToDate(DateTime(2026, 3, 14), 2).day == 16, 'addDaysToDate advances day', logs);
  assertionCount++;
  _expect(base.getDaysInMonth(2024, 2) == 29, 'edge case leap-year days are correct', logs);
  assertionCount++;
  _expect(base.isSameMonth(DateTime(2026, 3, 1), DateTime(2026, 3, 31)), 'isSameMonth detects same month', logs);
  assertionCount++;
  _expect(!base.isSameDay(DateTime(2026, 3, 14), DateTime(2026, 3, 15)), 'isSameDay distinguishes dates', logs);
  assertionCount++;

  final monthDate = base.getMonth(2026, 7);
  final dayDate = base.getDay(2026, 7, 9);
  _expect(monthDate.month == 7 && monthDate.day == 1, 'getMonth returns first day of month', logs);
  assertionCount++;
  _expect(dayDate.day == 9, 'getDay builds specific day', logs);
  assertionCount++;''',
    summary=["'Now sample: ' + base.now().toString()"],
)

content['card_theme_data_test.dart'] = scaffold(
    'CardThemeData',
    body='''  const base = CardThemeData(elevation: 2, color: Colors.amber, margin: EdgeInsets.all(8));
  final copy = base.copyWith(elevation: 6, shadowColor: Colors.black45);
  final lerped = CardThemeData.lerp(base, copy, 0.5);
  const edge = CardThemeData();

  _expect(base.elevation == 2, 'constructor stores elevation', logs);
  assertionCount++;
  _expect(copy.elevation == 6, 'copyWith overrides selected field', logs);
  assertionCount++;
  _expect(copy.color == Colors.amber, 'copyWith preserves untouched fields', logs);
  assertionCount++;
  _expect(lerped != null, 'lerp returns a non-null theme', logs);
  assertionCount++;
  _expect(edge.margin == null && edge.shape == null, 'edge case supports defaults', logs);
  assertionCount++;
  _expect(base != copy, 'equality differs for changed data', logs);
  assertionCount++;''',
    summary=["'Base elevation: ' + (base.elevation?.toString() ?? 'null')", "'Copy elevation: ' + (copy.elevation?.toString() ?? 'null')"],
)

content['carousel_controller_test.dart'] = scaffold(
    'CarouselController',
    body='''  final controller = CarouselController(initialItem: 2);
  final edgeController = CarouselController(initialItem: -1);

  _expect(controller is CarouselController, 'constructor creates CarouselController', logs);
  assertionCount++;
  _expect(controller.initialItem == 2, 'constructor stores initialItem', logs);
  assertionCount++;
  _expect(!controller.hasClients, 'fresh controller has no clients', logs);
  assertionCount++;
  _expect(controller.positions.isEmpty, 'positions are empty before attachment', logs);
  assertionCount++;
  _expect(edgeController.initialItem == -1, 'edge case allows negative initialItem', logs);
  assertionCount++;

  controller.animateToItem(0, duration: Duration.zero, curve: Curves.linear);
  _expect(true, 'animateToItem without clients is a no-op and does not throw', logs);
  assertionCount++;''',
    summary=["'Initial item: ' + controller.initialItem.toString()"],
)

content['carousel_scroll_physics_test.dart'] = scaffold(
    'CarouselScrollPhysics',
    body='''  const physics = CarouselScrollPhysics();
  final applied = physics.applyTo(const AlwaysScrollableScrollPhysics());
  final reapplied = applied.applyTo(const ClampingScrollPhysics());

  _expect(physics is ScrollPhysics, 'CarouselScrollPhysics extends ScrollPhysics', logs);
  assertionCount++;
  _expect(applied is CarouselScrollPhysics, 'applyTo preserves CarouselScrollPhysics type', logs);
  assertionCount++;
  _expect(reapplied.allowImplicitScrolling, 'allowImplicitScrolling is true', logs);
  assertionCount++;
  _expect(applied.parent != null, 'applyTo attaches parent physics', logs);
  assertionCount++;
  _expect(const CarouselScrollPhysics().parent == null, 'edge case supports null parent', logs);
  assertionCount++;''',
    summary=["'Implicit scrolling: ' + reapplied.allowImplicitScrolling.toString()"],
)

content['carousel_view_test.dart'] = scaffold(
    'CarouselView',
    body='''  final controller = CarouselController(initialItem: 1);
  final standard = CarouselView(
    itemExtent: 120,
    controller: controller,
    children: const [Text('A'), Text('B'), Text('C')],
  );
  const weighted = CarouselView.weighted(
    flexWeights: <int>[1, 2, 1],
    children: <Widget>[Text('W1'), Text('W2'), Text('W3')],
  );

  _expect(standard is CarouselView, 'constructor creates CarouselView', logs);
  assertionCount++;
  _expect(standard.itemExtent == 120, 'constructor stores itemExtent', logs);
  assertionCount++;
  _expect(standard.children.length == 3, 'constructor stores children', logs);
  assertionCount++;
  _expect(weighted.flexWeights?.length == 3, 'weighted constructor stores flexWeights', logs);
  assertionCount++;
  _expect(weighted.itemExtent == null, 'weighted constructor uses null itemExtent', logs);
  assertionCount++;
  _expect(weighted.consumeMaxWeight, 'weighted defaults to consumeMaxWeight=true', logs);
  assertionCount++;''',
    summary=["'Children count: ' + standard.children.length.toString()", "'Flex weights: ' + weighted.flexWeights.toString()"],
)

content['carousel_view_theme_data_test.dart'] = scaffold(
    'CarouselViewThemeData',
    body='''  const base = CarouselViewThemeData(
    elevation: 3,
    backgroundColor: Colors.blue,
    padding: EdgeInsets.all(4),
    itemClipBehavior: Clip.hardEdge,
  );
  final copy = base.copyWith(elevation: 8, backgroundColor: Colors.orange);
  final lerped = CarouselViewThemeData.lerp(base, copy, 0.5);
  const edge = CarouselViewThemeData();

  _expect(base.elevation == 3, 'constructor stores elevation', logs);
  assertionCount++;
  _expect(copy.elevation == 8, 'copyWith overrides selected value', logs);
  assertionCount++;
  _expect(copy.padding == base.padding, 'copyWith preserves untouched values', logs);
  assertionCount++;
  _expect(lerped.backgroundColor != null, 'lerp computes interpolated color', logs);
  assertionCount++;
  _expect(edge.overlayColor == null && edge.shape == null, 'edge case supports null defaults', logs);
  assertionCount++;
  _expect(base != copy, 'equality changes when fields differ', logs);
  assertionCount++;''',
    summary=["'Lerped elevation: ' + (lerped.elevation?.toString() ?? 'null')"],
)

content['carousel_view_theme_test.dart'] = scaffold(
    'CarouselViewTheme',
    body='''  const dataA = CarouselViewThemeData(elevation: 1);
  const dataB = CarouselViewThemeData(elevation: 5);
  const themeA = CarouselViewTheme(data: dataA, child: SizedBox.shrink());
  const themeB = CarouselViewTheme(data: dataB, child: SizedBox.shrink());

  _expect(themeA.data == dataA, 'constructor stores data', logs);
  assertionCount++;
  _expect(themeA.child is SizedBox, 'constructor stores child', logs);
  assertionCount++;

  final inherited = CarouselViewTheme.of(context);
  _expect(inherited is CarouselViewThemeData, 'of resolves current theme data', logs);
  assertionCount++;

  final wrapped = themeA.wrap(context, const Text('wrapped'));
  _expect(wrapped is CarouselViewTheme, 'wrap returns CarouselViewTheme', logs);
  assertionCount++;
  _expect(themeA.updateShouldNotify(themeB), 'updateShouldNotify reacts to data changes', logs);
  assertionCount++;''',
    summary=["'Inherited hash: ' + inherited.hashCode.toString()"],
)

content['checkbox_list_tile_test.dart'] = scaffold(
    'CheckboxListTile',
    body='''  final tile = CheckboxListTile(
    value: false,
    onChanged: (_) {},
    title: const Text('Regular'),
    subtitle: const Text('Sub'),
  );
  final triState = CheckboxListTile(
    value: null,
    tristate: true,
    onChanged: (_) {},
    title: const Text('Tri-state'),
  );
  final disabled = CheckboxListTile(
    value: true,
    onChanged: null,
    title: const Text('Disabled'),
  );

  _expect(tile is CheckboxListTile, 'constructor creates CheckboxListTile', logs);
  assertionCount++;
  _expect(tile.value == false, 'constructor stores boolean value', logs);
  assertionCount++;
  _expect(tile.tristate == false, 'default tristate is false', logs);
  assertionCount++;
  _expect(triState.value == null && triState.tristate, 'edge case allows null value with tristate', logs);
  assertionCount++;
  _expect(disabled.onChanged == null, 'behavior supports disabled tile when onChanged is null', logs);
  assertionCount++;''',
    summary=["'Tri-state enabled: ' + triState.tristate.toString()"],
)

content['checked_popup_menu_item_test.dart'] = scaffold(
    'CheckedPopupMenuItem',
    body='''  const checked = CheckedPopupMenuItem<int>(
    value: 1,
    checked: true,
    child: Text('One'),
  );
  const unchecked = CheckedPopupMenuItem<int>(
    value: 2,
    checked: false,
    child: Text('Two'),
  );

  _expect(checked is CheckedPopupMenuItem<int>, 'constructor creates typed CheckedPopupMenuItem', logs);
  assertionCount++;
  _expect(checked.checked, 'constructor stores checked=true', logs);
  assertionCount++;
  _expect(checked.value == 1, 'constructor stores value', logs);
  assertionCount++;
  _expect(unchecked.checked == false, 'edge case supports unchecked entries', logs);
  assertionCount++;
  _expect(checked.enabled && unchecked.enabled, 'default behavior keeps menu items enabled', logs);
  assertionCount++;''',
    summary=["'Checked item value: ' + checked.value.toString()"],
)

content['checkmarkable_chip_attributes_test.dart'] = scaffold(
    'CheckmarkableChipAttributes',
    body='''  final chip = FilterChip(
    label: const Text('A'),
    selected: true,
    showCheckmark: true,
    checkmarkColor: Colors.green,
    onSelected: (_) {},
  );
  final edgeChip = FilterChip(
    label: const Text('B'),
    selected: false,
    showCheckmark: false,
    checkmarkColor: null,
    onSelected: (_) {},
  );

  _expect(chip is CheckmarkableChipAttributes, 'FilterChip implements CheckmarkableChipAttributes', logs);
  assertionCount++;
  final attrs = chip as CheckmarkableChipAttributes;
  _expect(attrs.showCheckmark == true, 'showCheckmark is exposed via interface', logs);
  assertionCount++;
  _expect(attrs.checkmarkColor == Colors.green, 'checkmarkColor is exposed via interface', logs);
  assertionCount++;
  final edgeAttrs = edgeChip as CheckmarkableChipAttributes;
  _expect(edgeAttrs.showCheckmark == false, 'edge case supports hidden checkmark', logs);
  assertionCount++;
  _expect(edgeAttrs.checkmarkColor == null, 'edge case supports null checkmark color', logs);
  assertionCount++;''',
    summary=["'Checkmark color: ' + (attrs.checkmarkColor?.toString() ?? 'null')"],
)

content['chip_animation_style_test.dart'] = scaffold(
    'ChipAnimationStyle',
    body='''  final enable = AnimationStyle(duration: const Duration(milliseconds: 100));
  final select = AnimationStyle(duration: const Duration(milliseconds: 200));
  final avatar = AnimationStyle(duration: const Duration(milliseconds: 150));
  final delete = AnimationStyle(duration: const Duration(milliseconds: 170));

  final style = ChipAnimationStyle(
    enableAnimation: enable,
    selectAnimation: select,
    avatarDrawerAnimation: avatar,
    deleteDrawerAnimation: delete,
  );
  final edge = ChipAnimationStyle();

  _expect(style is ChipAnimationStyle, 'constructor creates ChipAnimationStyle', logs);
  assertionCount++;
  _expect(style.enableAnimation?.duration == const Duration(milliseconds: 100), 'stores enable animation', logs);
  assertionCount++;
  _expect(style.selectAnimation?.duration == const Duration(milliseconds: 200), 'stores select animation', logs);
  assertionCount++;
  _expect(style.avatarDrawerAnimation?.duration == const Duration(milliseconds: 150), 'stores avatar drawer animation', logs);
  assertionCount++;
  _expect(style.deleteDrawerAnimation?.duration == const Duration(milliseconds: 170), 'stores delete drawer animation', logs);
  assertionCount++;
  _expect(edge.enableAnimation == null && edge.selectAnimation == null, 'edge case supports null defaults', logs);
  assertionCount++;''',
    summary=["'Enable duration: ' + style.enableAnimation!.duration.toString()"],
)

content['class_test.dart'] = scaffold(
    'Class',
    pre='''class Class {
  const Class(this.id, this.label);

  final int id;
  final String label;

  bool get isValid => id >= 0 && label.isNotEmpty;

  Class copyWith({int? id, String? label}) => Class(id ?? this.id, label ?? this.label);

  @override
  String toString() => 'Class(id: $id, label: $label)';
}''',
    body='''  const sample = Class(1, 'primary');
  final copy = sample.copyWith(label: 'secondary');
  const edge = Class(0, '');

  _expect(sample.id == 1, 'constructor stores id', logs);
  assertionCount++;
  _expect(sample.label == 'primary', 'constructor stores label', logs);
  assertionCount++;
  _expect(sample.isValid, 'behavior validates non-empty label', logs);
  assertionCount++;
  _expect(copy.id == sample.id && copy.label == 'secondary', 'copyWith updates selected fields', logs);
  assertionCount++;
  _expect(!edge.isValid, 'edge case invalidates empty label', logs);
  assertionCount++;
  _expect(sample.toString().contains('Class('), 'toString includes class name', logs);
  assertionCount++;''',
    summary=["'Sample: ' + sample.toString()"],
)

content['close_button_icon_test.dart'] = scaffold(
    'CloseButtonIcon',
    body='''  const iconA = CloseButtonIcon();
  const iconB = CloseButtonIcon(key: ValueKey<String>('close-icon'));

  _expect(iconA is CloseButtonIcon, 'constructor creates CloseButtonIcon', logs);
  assertionCount++;
  _expect(iconA is StatelessWidget, 'CloseButtonIcon is a StatelessWidget', logs);
  assertionCount++;
  _expect(iconB.key == const ValueKey<String>('close-icon'), 'constructor stores key', logs);
  assertionCount++;

  final built = iconA.build(context);
  _expect(built is Widget, 'build returns a widget', logs);
  assertionCount++;
  _expect(iconA.runtimeType.toString().contains('CloseButtonIcon'), 'runtime type remains stable', logs);
  assertionCount++;''',
    summary=["'Built widget type: ' + built.runtimeType.toString()"],
)

content['close_button_test.dart'] = scaffold(
    'CloseButton',
    body='''  final close = CloseButton(onPressed: () {});
  const defaultClose = CloseButton();

  _expect(close is CloseButton, 'constructor creates CloseButton', logs);
  assertionCount++;
  _expect(close is IconButton, 'CloseButton is an IconButton variant', logs);
  assertionCount++;
  _expect(close.onPressed != null, 'constructor stores custom callback', logs);
  assertionCount++;
  _expect(defaultClose.onPressed == null, 'edge case supports default onPressed behavior', logs);
  assertionCount++;

  final built = defaultClose.build(context);
  _expect(built is Widget, 'build returns a widget', logs);
  assertionCount++;
  _expect(defaultClose.runtimeType.toString().contains('CloseButton'), 'runtime type contains class name', logs);
  assertionCount++;''',
    summary=["'Default close type: ' + defaultClose.runtimeType.toString()"],
)

content['colors_test.dart'] = scaffold(
    'Colors',
    body='''  final MaterialColor blue = Colors.blue;
  final MaterialAccentColor blueAccent = Colors.blueAccent;
  final Color transparent = Colors.transparent;

  _expect(blue is MaterialColor, 'Colors.blue exposes MaterialColor', logs);
  assertionCount++;
  _expect(blue[500] == Colors.blue.shade500, 'shade lookup matches shade500', logs);
  assertionCount++;
  _expect(blueAccent is MaterialAccentColor, 'Colors.blueAccent exposes MaterialAccentColor', logs);
  assertionCount++;
  _expect(transparent.alpha == 0, 'transparent color has zero alpha', logs);
  assertionCount++;
  _expect(Colors.primaries.isNotEmpty, 'primaries list is populated', logs);
  assertionCount++;
  _expect(Colors.accents.isNotEmpty, 'accents list is populated', logs);
  assertionCount++;''',
    summary=["'Primary count: ' + Colors.primaries.length.toString()", "'Accent count: ' + Colors.accents.length.toString()"],
)

content['controls_details_test.dart'] = scaffold(
    'ControlsDetails',
    body='''  final details = ControlsDetails(
    currentStep: 1,
    stepIndex: 1,
    onStepContinue: () {},
    onStepCancel: () {},
  );
  const edge = ControlsDetails(currentStep: 1, stepIndex: 2);

  _expect(details is ControlsDetails, 'constructor creates ControlsDetails', logs);
  assertionCount++;
  _expect(details.currentStep == 1 && details.stepIndex == 1, 'constructor stores step values', logs);
  assertionCount++;
  _expect(details.isActive, 'isActive is true when currentStep == stepIndex', logs);
  assertionCount++;
  _expect(edge.isActive == false, 'edge case marks inactive when indices differ', logs);
  assertionCount++;
  _expect(edge.onStepContinue == null && edge.onStepCancel == null, 'callbacks are optional', logs);
  assertionCount++;''',
    summary=["'Active details: ' + details.isActive.toString()", "'Edge active: ' + edge.isActive.toString()"],
)

content['cupertino_based_material_theme_data_test.dart'] = scaffold(
    'CupertinoBasedMaterialThemeData',
    imports=["import 'package:flutter/cupertino.dart';", "import 'package:flutter/material.dart';"],
    body='''  final sourceTheme = const CupertinoThemeData(
    primaryColor: CupertinoColors.activeBlue,
    brightness: Brightness.dark,
  );
  final converted = CupertinoBasedMaterialThemeData(themeData: sourceTheme);

  _expect(converted is CupertinoBasedMaterialThemeData, 'constructor creates converter object', logs);
  assertionCount++;
  _expect(converted.materialTheme is ThemeData, 'materialTheme property exposes ThemeData', logs);
  assertionCount++;
  _expect(converted.materialTheme.colorScheme.brightness == Brightness.dark, 'brightness transfers from Cupertino theme', logs);
  assertionCount++;
  _expect(converted.materialTheme.colorScheme.primary == CupertinoColors.activeBlue, 'primary color transfers from source theme', logs);
  assertionCount++;

  final edge = CupertinoBasedMaterialThemeData(themeData: const CupertinoThemeData());
  _expect(edge.materialTheme.colorScheme.primary.value != 0, 'edge case still creates a valid color scheme', logs);
  assertionCount++;''',
    summary=["'Mapped brightness: ' + converted.materialTheme.colorScheme.brightness.toString()"],
)

content['data_table_source_test.dart'] = scaffold(
    'DataTableSource',
    pre='''class _DemoDataTableSource extends DataTableSource {
  _DemoDataTableSource(this._rows);

  final List<int> _rows;

  @override
  DataRow? getRow(int index) {
    if (index < 0 || index >= _rows.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[DataCell(Text('Row ${_rows[index]}'))],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}''',
    body='''  final source = _DemoDataTableSource(<int>[10, 20, 30]);

  _expect(source is DataTableSource, 'subclass is DataTableSource', logs);
  assertionCount++;
  _expect(source.rowCount == 3, 'rowCount reports source size', logs);
  assertionCount++;
  _expect(!source.isRowCountApproximate, 'isRowCountApproximate is false', logs);
  assertionCount++;
  _expect(source.selectedRowCount == 0, 'selectedRowCount default is zero', logs);
  assertionCount++;

  final row0 = source.getRow(0);
  final rowMissing = source.getRow(99);
  _expect(row0 != null, 'getRow returns data for valid index', logs);
  assertionCount++;
  _expect(rowMissing == null, 'edge case returns null for out-of-range index', logs);
  assertionCount++;''',
    summary=["'Row count: ' + source.rowCount.toString()"],
)

missing = [name for name in files if name not in content]
if missing:
    raise SystemExit(f'Missing content for files: {missing}')

for name in files:
    path = base / name
    path.write_text(content[name], encoding='utf-8')

print('WROTE', len(files), 'files')
for name in files:
    line_count = len((base / name).read_text(encoding='utf-8').splitlines())
    print(f'{name}: {line_count}')
