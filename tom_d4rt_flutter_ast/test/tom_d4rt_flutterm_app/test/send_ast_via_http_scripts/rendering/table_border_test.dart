// ignore_for_file: avoid_print
// D4rt deep-demo: TableBorder — Copper / Bronze theme, prefix tb
import 'package:flutter/material.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget tbSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFFB87333), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8B5E3C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget tbChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget tbInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8B5E3C))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF5A504A))),
        ),
      ],
    ),
  );
}

Widget tbCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF5ED),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(code,
        style: TextStyle(
            fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF8B5E3C))),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ── Section 1: Title ──────────────────────────────────────────
  print('\n[1] TableBorder Overview');
  print('  Describes borders for a Table widget');
  print('  Supports outer + inner borders');
  print('  Customizable per side');

  final tbTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFB87333), Color(0xFF8B5E3C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('TableBorder',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Border configuration for Table widgets — outer edges and inner dividers',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFFFDCC4))),
        SizedBox(height: 8.0),
        Wrap(
          children: [
            tbChip('Outer Borders', Color(0xFFCD8544)),
            tbChip('Inner Dividers', Color(0xFFB87333)),
            tbChip('Symmetric', Color(0xFFA06030)),
            tbChip('Lerp', Color(0xFF8B5E3C)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Constructors ──────────────────────────────────
  print('\n[2] TableBorder Constructors');
  final borderAll = TableBorder.all(color: Color(0xFFB87333), width: 2.0);
  final borderCustom = TableBorder(
    top: BorderSide(color: Color(0xFFB87333), width: 2.0),
    right: BorderSide(color: Color(0xFFCD8544), width: 1.0),
    bottom: BorderSide(color: Color(0xFFA06030), width: 3.0),
    left: BorderSide(color: Color(0xFF8B5E3C), width: 1.0),
    horizontalInside: BorderSide(color: Color(0xFFD4A76A), width: 0.5),
    verticalInside: BorderSide(color: Color(0xFFD4A76A), width: 0.5),
  );
  print('  TableBorder.all(color, width)');
  print('  TableBorder.symmetric(inside, outside)');
  print('  TableBorder(top, right, bottom, left, hInside, vInside)');

  final constructors = <Map<String, dynamic>>[
    {'label': 'TableBorder.all()', 'color': Color(0xFFB87333),
     'desc': 'Uniform border on all sides and all dividers',
     'code': 'TableBorder.all(color: Colors.grey, width: 2.0)'},
    {'label': 'TableBorder.symmetric()', 'color': Color(0xFFCD8544),
     'desc': 'Inside dividers and outside edges configured separately',
     'code': 'TableBorder.symmetric(\n  inside: BorderSide(width: 1),\n  outside: BorderSide(width: 3))'},
    {'label': 'TableBorder()', 'color': Color(0xFF8B5E3C),
     'desc': 'Full control over each of 6 border sides',
     'code': 'TableBorder(\n  top: ..., right: ...,\n  bottom: ..., left: ...,\n  horizontalInside: ...,\n  verticalInside: ...)'},
  ];

  final tbConstructorsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      children: constructors.map((c) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border(left: BorderSide(color: c['color'] as Color, width: 4.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tbChip(c['label'] as String, c['color'] as Color),
              SizedBox(height: 4.0),
              Text(c['desc'] as String,
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF5A504A))),
              SizedBox(height: 6.0),
              tbCodeBlock(c['code'] as String),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 3: Border Sides Visual ───────────────────────────
  print('\n[3] Border Sides — 6 Configurable Edges');
  print('  top, right, bottom, left (outer)');
  print('  horizontalInside, verticalInside (inner dividers)');

  final tbSidesSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('6 configurable border sides',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,
                color: Color(0xFF8B5E3C))),
        SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          height: 140.0,
          child: Stack(
            children: [
              Positioned(
                left: 20.0, top: 10.0,
                child: Container(
                  width: 260.0, height: 120.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFB87333), width: 3.0),
                      right: BorderSide(color: Color(0xFFCD8544), width: 3.0),
                      bottom: BorderSide(color: Color(0xFFA06030), width: 3.0),
                      left: BorderSide(color: Color(0xFF8B5E3C), width: 3.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Container(
                              decoration: BoxDecoration(border: Border(
                                right: BorderSide(color: Color(0xFFD4A76A), width: 1.0),
                                bottom: BorderSide(color: Color(0xFFD4A76A), width: 1.0),
                              )),
                              child: Center(child: Text('Cell', style: TextStyle(fontSize: 9.0, color: Color(0xFF8B5E3C)))),
                            )),
                            Expanded(child: Container(
                              decoration: BoxDecoration(border: Border(
                                bottom: BorderSide(color: Color(0xFFD4A76A), width: 1.0),
                              )),
                              child: Center(child: Text('Cell', style: TextStyle(fontSize: 9.0, color: Color(0xFF8B5E3C)))),
                            )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Container(
                              decoration: BoxDecoration(border: Border(
                                right: BorderSide(color: Color(0xFFD4A76A), width: 1.0),
                              )),
                              child: Center(child: Text('Cell', style: TextStyle(fontSize: 9.0, color: Color(0xFF8B5E3C)))),
                            )),
                            Expanded(child: Center(child: Text('Cell', style: TextStyle(fontSize: 9.0, color: Color(0xFF8B5E3C))))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(left: 100.0, top: 0.0,
                child: Text('top', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Color(0xFFB87333)))),
              Positioned(right: 0.0, top: 55.0,
                child: Text('right', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Color(0xFFCD8544)))),
              Positioned(left: 100.0, bottom: 0.0,
                child: Text('bottom', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Color(0xFFA06030)))),
              Positioned(left: 0.0, top: 55.0,
                child: Text('left', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Color(0xFF8B5E3C)))),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        tbInfoRow('Outer:', 'top, right, bottom, left'),
        tbInfoRow('Inner:', 'horizontalInside, verticalInside'),
        tbInfoRow('Type:', 'Each side is a BorderSide'),
      ],
    ),
  );

  // ── Section 4: TableBorder.all Visual ────────────────────────
  print('\n[4] TableBorder.all — Uniform Borders');
  print('  All 6 sides identical');

  final allWidths = <double>[0.5, 1.0, 2.0, 3.0];

  final tbAllSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Uniform borders at different widths',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF8B5E3C))),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: allWidths.map((w) {
            return Column(
              children: [
                SizedBox(
                  width: 60.0, height: 40.0,
                  child: Table(
                    border: TableBorder.all(color: Color(0xFFB87333), width: w),
                    children: [
                      TableRow(children: [SizedBox(height: 18.0), SizedBox(height: 18.0)]),
                      TableRow(children: [SizedBox(height: 18.0), SizedBox(height: 18.0)]),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text('width: $w', style: TextStyle(fontSize: 9.0, color: Color(0xFF8B5E3C))),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 10.0),
        tbCodeBlock('TableBorder.all(\n  color: Color(0xFFB87333),\n  width: 2.0,\n  style: BorderStyle.solid,\n)'),
      ],
    ),
  );

  // ── Section 5: Symmetric Visual ──────────────────────────────
  print('\n[5] TableBorder.symmetric — Inside vs Outside');
  print('  inside: BorderSide for dividers');
  print('  outside: BorderSide for edges');

  final tbSymmetricSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Thin in / thick out', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
                SizedBox(height: 4.0),
                SizedBox(
                  width: 120.0, height: 60.0,
                  child: Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Color(0xFFD4A76A), width: 0.5),
                      outside: BorderSide(color: Color(0xFF8B5E3C), width: 3.0),
                    ),
                    children: [
                      TableRow(children: [SizedBox(height: 28.0), SizedBox(height: 28.0)]),
                      TableRow(children: [SizedBox(height: 28.0), SizedBox(height: 28.0)]),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text('Thick in / thin out', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
                SizedBox(height: 4.0),
                SizedBox(
                  width: 120.0, height: 60.0,
                  child: Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(color: Color(0xFFB87333), width: 3.0),
                      outside: BorderSide(color: Color(0xFFD4A76A), width: 0.5),
                    ),
                    children: [
                      TableRow(children: [SizedBox(height: 28.0), SizedBox(height: 28.0)]),
                      TableRow(children: [SizedBox(height: 28.0), SizedBox(height: 28.0)]),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        tbCodeBlock('TableBorder.symmetric(\n  inside: BorderSide(width: 0.5),\n  outside: BorderSide(width: 3.0),\n)'),
      ],
    ),
  );

  // ── Section 6: Per-Side Customization ────────────────────────
  print('\n[6] Per-Side Customization');
  print('  Each of 6 sides independently configured');

  final sideInfo = <Map<String, dynamic>>[
    {'name': 'top', 'side': borderCustom.top, 'color': Color(0xFFB87333)},
    {'name': 'right', 'side': borderCustom.right, 'color': Color(0xFFCD8544)},
    {'name': 'bottom', 'side': borderCustom.bottom, 'color': Color(0xFFA06030)},
    {'name': 'left', 'side': borderCustom.left, 'color': Color(0xFF8B5E3C)},
    {'name': 'hInside', 'side': borderCustom.horizontalInside, 'color': Color(0xFFD4A76A)},
    {'name': 'vInside', 'side': borderCustom.verticalInside, 'color': Color(0xFFD4A76A)},
  ];

  final tbCustomSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      children: sideInfo.map((si) {
        final side = si['side'] as BorderSide;
        return Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Container(width: 24.0, height: 4.0, color: si['color'] as Color),
              SizedBox(width: 8.0),
              SizedBox(
                width: 70.0,
                child: Text(si['name'] as String,
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                        fontFamily: 'monospace', color: si['color'] as Color)),
              ),
              Expanded(
                child: Text('width: ${side.width}, color: #${side.color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF5A504A))),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 7: Properties ────────────────────────────────────
  print('\n[7] TableBorder Properties');
  print('  dimensions: EdgeInsets');
  print('  isUniform: ${borderAll.isUniform}');

  final dims = borderAll.dimensions;

  final tbPropertiesSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tbInfoRow('dimensions:', dims.toString()),
        tbInfoRow('isUniform (all):', '${borderAll.isUniform}'),
        tbInfoRow('isUniform (custom):', '${borderCustom.isUniform}'),
        tbInfoRow('borderRadius:', 'BorderRadius.zero (default)'),
        SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  children: [
                    Text('Uniform', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Color(0xFFB87333))),
                    Text('isUniform: true', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF5A504A))),
                    SizedBox(height: 4.0),
                    Container(width: 50.0, height: 30.0,
                      decoration: BoxDecoration(border: Border.all(color: Color(0xFFB87333), width: 2.0))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  children: [
                    Text('Non-Uniform', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Color(0xFF8B5E3C))),
                    Text('isUniform: false', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF5A504A))),
                    SizedBox(height: 4.0),
                    Container(width: 50.0, height: 30.0,
                      decoration: BoxDecoration(border: Border(
                        top: BorderSide(color: Color(0xFFB87333), width: 3.0),
                        right: BorderSide(color: Color(0xFFCD8544), width: 1.0),
                        bottom: BorderSide(color: Color(0xFFA06030), width: 2.0),
                        left: BorderSide(color: Color(0xFF8B5E3C), width: 1.0),
                      ))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ── Section 8: Live Table Examples ───────────────────────────
  print('\n[8] Live Table Examples');

  final tbLiveSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Style 1: Classic grid', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
        SizedBox(height: 4.0),
        Table(
          border: TableBorder.all(color: Color(0xFFB87333), width: 1.0),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Color(0xFFB87333).withValues(alpha: 0.1)),
              children: [
                Padding(padding: EdgeInsets.all(6.0), child: Text('Header A', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF8B5E3C)))),
                Padding(padding: EdgeInsets.all(6.0), child: Text('Header B', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF8B5E3C)))),
                Padding(padding: EdgeInsets.all(6.0), child: Text('Header C', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF8B5E3C)))),
              ],
            ),
            TableRow(children: [
              Padding(padding: EdgeInsets.all(6.0), child: Text('Row 1', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('Data', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('Value', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
            ]),
            TableRow(children: [
              Padding(padding: EdgeInsets.all(6.0), child: Text('Row 2', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('Data', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('Value', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
            ]),
          ],
        ),
        SizedBox(height: 12.0),
        Text('Style 2: Outer only', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
        SizedBox(height: 4.0),
        Table(
          border: TableBorder.symmetric(
            inside: BorderSide.none,
            outside: BorderSide(color: Color(0xFF8B5E3C), width: 2.0),
          ),
          children: [
            TableRow(children: [
              Padding(padding: EdgeInsets.all(6.0), child: Text('No inner', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('borders', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('here', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
            ]),
          ],
        ),
        SizedBox(height: 12.0),
        Text('Style 3: Horizontal dividers only', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
        SizedBox(height: 4.0),
        Table(
          border: TableBorder(
            top: BorderSide.none, right: BorderSide.none,
            bottom: BorderSide(color: Color(0xFFB87333), width: 1.0),
            left: BorderSide.none,
            horizontalInside: BorderSide(color: Color(0xFFD4A76A), width: 1.0),
            verticalInside: BorderSide.none,
          ),
          children: [
            TableRow(children: [
              Padding(padding: EdgeInsets.all(6.0), child: Text('Row dividers', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('only', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C)))),
            ]),
            TableRow(children: [
              Padding(padding: EdgeInsets.all(6.0), child: Text('Like a', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
              Padding(padding: EdgeInsets.all(6.0), child: Text('list view', style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A)))),
            ]),
          ],
        ),
      ],
    ),
  );

  // ── Section 9: Scale ─────────────────────────────────────────
  print('\n[9] TableBorder.scale()');
  print('  scale(0.5): thinner');
  print('  scale(2.0): thicker');

  final scaleFactors = <double>[0.25, 0.5, 1.0, 1.5, 2.0];

  final tbScaleSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scale multiplier applied to all border widths',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF8B5E3C))),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: scaleFactors.map((f) {
            return Column(
              children: [
                SizedBox(
                  width: 45.0, height: 30.0,
                  child: Table(
                    border: TableBorder.all(color: Color(0xFFB87333), width: 2.0).scale(f),
                    children: [
                      TableRow(children: [SizedBox(height: 13.0), SizedBox(height: 13.0)]),
                      TableRow(children: [SizedBox(height: 13.0), SizedBox(height: 13.0)]),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text('${f}x', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 8.0),
        tbCodeBlock('final scaled = border.scale(0.5);\n// All widths multiplied by factor'),
      ],
    ),
  );

  // ── Section 10: Lerp ─────────────────────────────────────────
  print('\n[10] TableBorder.lerp — Animation Interpolation');
  final lerpA = TableBorder.all(color: Color(0xFFB87333), width: 1.0);
  final lerpB = TableBorder.all(color: Color(0xFF8B5E3C), width: 4.0);
  print('  lerp(a, b, 0.5): midpoint');

  final lerpSteps = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

  final tbLerpSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Smooth transition between two TableBorder configs',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF8B5E3C))),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: lerpSteps.map((t) {
            return Column(
              children: [
                SizedBox(
                  width: 50.0, height: 30.0,
                  child: Table(
                    border: TableBorder.lerp(lerpA, lerpB, t),
                    children: [
                      TableRow(children: [SizedBox(height: 13.0), SizedBox(height: 13.0)]),
                      TableRow(children: [SizedBox(height: 13.0), SizedBox(height: 13.0)]),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text('t=$t', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: Color(0xFF8B5E3C))),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 8.0),
        tbCodeBlock('TableBorder.lerp(borderA, borderB, t)\n// t: 0.0 = A, 1.0 = B'),
      ],
    ),
  );

  // ── Section 11: Color Variations ─────────────────────────────
  print('\n[11] Color Variations');

  final colorVars = <Map<String, dynamic>>[
    {'label': 'Warm', 'color': Color(0xFFB87333)},
    {'label': 'Cool', 'color': Color(0xFF5B7BA0)},
    {'label': 'Forest', 'color': Color(0xFF4A7C59)},
    {'label': 'Dusk', 'color': Color(0xFF7B5EA7)},
  ];

  final tbColorSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colorVars.map((cv) {
        return Column(
          children: [
            SizedBox(
              width: 65.0, height: 40.0,
              child: Table(
                border: TableBorder.all(color: cv['color'] as Color, width: 1.5),
                children: [
                  TableRow(children: [SizedBox(height: 18.0), SizedBox(height: 18.0)]),
                  TableRow(children: [SizedBox(height: 18.0), SizedBox(height: 18.0)]),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(cv['label'] as String,
                style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w600, color: cv['color'] as Color)),
          ],
        );
      }).toList(),
    ),
  );

  // ── Section 12: BorderRadius ─────────────────────────────────
  print('\n[12] BorderRadius with TableBorder');
  print('  Applies rounded corners to outer border');

  final tbRadiusSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rounded corner tables',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF8B5E3C))),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [0.0, 4.0, 8.0, 12.0].map((r) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(r),
                  child: SizedBox(
                    width: 60.0, height: 40.0,
                    child: Table(
                      border: TableBorder.all(
                        color: Color(0xFFB87333), width: 1.5,
                        borderRadius: BorderRadius.circular(r),
                      ),
                      children: [
                        TableRow(children: [SizedBox(height: 18.0), SizedBox(height: 18.0)]),
                        TableRow(children: [SizedBox(height: 18.0), SizedBox(height: 18.0)]),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('r: ${r.toInt()}', style: TextStyle(fontSize: 9.0, color: Color(0xFF8B5E3C))),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: 8.0),
        tbCodeBlock('TableBorder.all(\n  borderRadius: BorderRadius.circular(8.0),\n)'),
      ],
    ),
  );

  // ── Section 13: Dimensions ───────────────────────────────────
  print('\n[13] Dimensions — Border Space');
  print('  dimensions: $dims');

  final tbDimensionsSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Space occupied by borders in layout',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF8B5E3C))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            children: [
              tbInfoRow('top:', '${dims.top}'),
              tbInfoRow('right:', '${dims.right}'),
              tbInfoRow('bottom:', '${dims.bottom}'),
              tbInfoRow('left:', '${dims.left}'),
              Divider(color: Color(0xFFE8CDB4)),
              tbInfoRow('Horizontal:', '${dims.horizontal}'),
              tbInfoRow('Vertical:', '${dims.vertical}'),
              tbInfoRow('Collapsed size:', dims.collapsedSize.toString()),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 14: Usage Context ────────────────────────────────
  print('\n[14] Usage Context');
  print('  Table(border: tableBorder)');

  final usageContexts = <Map<String, dynamic>>[
    {'widget': 'Table', 'icon': Icons.grid_on, 'color': Color(0xFFB87333),
     'prop': 'border: TableBorder', 'desc': 'Direct border property on Table widget'},
    {'widget': 'DataTable', 'icon': Icons.table_chart, 'color': Color(0xFFCD8544),
     'prop': 'decoration + dividers', 'desc': 'Internal border logic via DataTable theming'},
    {'widget': 'GridView', 'icon': Icons.grid_view, 'color': Color(0xFF8B5E3C),
     'prop': 'Custom painting', 'desc': 'Manual border painting in custom rendering'},
  ];

  final tbUsageSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8F2),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      children: usageContexts.map((uc) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            children: [
              Icon(uc['icon'] as IconData, color: uc['color'] as Color, size: 24.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(uc['widget'] as String,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: uc['color'] as Color)),
                    Text(uc['prop'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Color(0xFF8B5E3C))),
                    Text(uc['desc'] as String,
                        style: TextStyle(fontSize: 10.0, color: Color(0xFF5A504A))),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );

  // ── Section 15: Equality ─────────────────────────────────────
  print('\n[15] Equality & HashCode');
  final eq1 = TableBorder.all(color: Color(0xFFB87333), width: 1.0);
  final eq2 = TableBorder.all(color: Color(0xFFB87333), width: 1.0);
  final eq3 = TableBorder.all(color: Color(0xFF000000), width: 2.0);
  print('  eq1 == eq2: ${eq1 == eq2}');
  print('  eq1 == eq3: ${eq1 == eq3}');

  final tbEqualitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAEDE0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFE8CDB4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Structural equality — compares all 6 sides',
            style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic, color: Color(0xFF8B5E3C))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            children: [
              tbInfoRow('Same config:', '${eq1 == eq2}'),
              tbInfoRow('Different config:', '${eq1 == eq3}'),
              tbInfoRow('hashCode eq1:', '${eq1.hashCode}'),
              tbInfoRow('hashCode eq2:', '${eq2.hashCode}'),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  Constructors: all(), symmetric(), full');
  print('  Methods: scale(), lerp()');

  final tbSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF8B5E3C), Color(0xFFB87333)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('TableBorder Dashboard',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(children: [
              Text('3', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFFFFDCC4))),
              Text('Constructors', style: TextStyle(fontSize: 10.0, color: Color(0xFFFFDCC4))),
            ]),
            Column(children: [
              Text('6', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFFFFDCC4))),
              Text('Border Sides', style: TextStyle(fontSize: 10.0, color: Color(0xFFFFDCC4))),
            ]),
            Column(children: [
              Text('2', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFFFFDCC4))),
              Text('Methods', style: TextStyle(fontSize: 10.0, color: Color(0xFFFFDCC4))),
            ]),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0, runSpacing: 4.0, alignment: WrapAlignment.center,
          children: [
            tbChip('all()', Color(0xFFCD8544)),
            tbChip('symmetric()', Color(0xFFB87333)),
            tbChip('scale()', Color(0xFFA06030)),
            tbChip('lerp()', Color(0xFF8B5E3C)),
            tbChip('dimensions', Color(0xFF6B4423)),
          ],
        ),
      ],
    ),
  );

  print('\nTableBorder Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tbTitleSection,
        tbSectionHeader('Constructors', Icons.build),
        tbConstructorsSection,
        tbSectionHeader('Border Sides — 6 Edges', Icons.border_all),
        tbSidesSection,
        tbSectionHeader('TableBorder.all — Uniform', Icons.grid_on),
        tbAllSection,
        tbSectionHeader('TableBorder.symmetric', Icons.swap_horiz),
        tbSymmetricSection,
        tbSectionHeader('Per-Side Customization', Icons.tune),
        tbCustomSection,
        tbSectionHeader('Properties', Icons.info_outline),
        tbPropertiesSection,
        tbSectionHeader('Live Table Examples', Icons.table_chart),
        tbLiveSection,
        tbSectionHeader('Scale Method', Icons.aspect_ratio),
        tbScaleSection,
        tbSectionHeader('Lerp — Animation', Icons.animation),
        tbLerpSection,
        tbSectionHeader('Color Variations', Icons.palette),
        tbColorSection,
        tbSectionHeader('BorderRadius', Icons.rounded_corner),
        tbRadiusSection,
        tbSectionHeader('Dimensions', Icons.straighten),
        tbDimensionsSection,
        tbSectionHeader('Usage Context', Icons.widgets),
        tbUsageSection,
        tbSectionHeader('Equality & HashCode', Icons.compare),
        tbEqualitySection,
        SizedBox(height: 8.0),
        tbSummarySection,
      ],
    ),
  );
}
