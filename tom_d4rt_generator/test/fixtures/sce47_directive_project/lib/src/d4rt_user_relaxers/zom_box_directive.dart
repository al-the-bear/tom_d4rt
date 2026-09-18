/// Fixture: a `@D4rtUserRelaxer` directive in the folder the pre-scan reads.
library;

import 'package:tom_d4rt/d4rt.dart';

/// Explicit single-slot variants — no wildcard, so they expand without a
/// candidate pool.
@D4rtUserRelaxer(
  'package:zom_sce47/boxes.dart',
  'ZomBox',
  variants: ['ZomCustomer', 'ZomOrder'],
)
class ZomBoxUserRelaxer extends D4UserRelaxer {
  @override
  String get baseTypeName => 'ZomBox';
}
