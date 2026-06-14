## 0.1.0

Initial pub.dev release of the analyzer-free Flutter Material bridge runtime —
the AST-driven counterpart to `tom_d4rt_flutter`, specialized for over-the-air
and web delivery (no `analyzer` dependency).

- `FlutterD4rt` — executes D4rt scripts that return Flutter widget trees, built
  on the zero-dependency `tom_d4rt_ast` interpreter (no `analyzer`, no
  `dart:io`). Web-safe: suitable for shipping in a Flutter app that downloads
  pre-compiled `AstBundle` JSON and renders UI on device.
- `build<Widget>(...)` renders from a reconstructed `AstBundle` / `SAstNode`
  tree rather than parsing source on device.
- Full generated Flutter Material bridge surface plus hand-written runtime
  registrations (interface proxies, type relaxers, generic factories) and
  `d4rt_user_bridges/` overrides — kept in sync with the source-based
  `tom_d4rt_flutter`, differing only in the analyzer-free execution path.
