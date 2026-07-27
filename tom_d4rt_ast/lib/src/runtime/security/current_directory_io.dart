import 'dart:io';

/// The process working directory, used to absolutize a relative permission
/// path before it is matched against an operation path.
///
/// Lives behind a conditional import (see `current_directory_web.dart`) so
/// `permissions.dart` — which every consumer pulls in — stays free of a hard
/// `dart:io` dependency. The twin file in `tom_d4rt_ast` must compile for web,
/// where that package puts all of `dart:io` behind `dart.library.html`.
String currentDirectoryPath() => Directory.current.path;
