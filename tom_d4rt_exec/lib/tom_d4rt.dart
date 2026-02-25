/// Compatibility re-export for bridge files.
///
/// The D4rt bridge generator produces imports referencing
/// `package:tom_d4rt/tom_d4rt.dart`. When these are adapted
/// for tom_d4rt_exec, they become `package:tom_d4rt_exec/tom_d4rt.dart`.
/// This file ensures those imports resolve correctly.
library;

export 'd4rt.dart';
