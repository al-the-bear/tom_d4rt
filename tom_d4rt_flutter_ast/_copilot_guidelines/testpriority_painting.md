# Test Priority: painting

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core classes used in virtually every Flutter application.

| Class | Description |
|-------|-------------|
| EdgeInsets | Padding/margin - fundamental layout |
| EdgeInsetsDirectional | RTL-aware padding |
| EdgeInsetsGeometry | Base padding class |
| Alignment | Widget alignment - layout essential |
| AlignmentDirectional | RTL-aware alignment |
| AlignmentGeometry | Base alignment class |
| BorderRadius | Corner rounding - common styling |
| BorderRadiusDirectional | RTL-aware corners |
| BorderRadiusGeometry | Base border radius |
| BoxDecoration | Container styling - backgrounds/borders |
| Border | Border styling |
| BorderSide | Individual border side |
| TextStyle | Text formatting |
| TextSpan | Rich text spans |
| AssetImage | Asset image loading |
| NetworkImage | URL image loading |
| LinearGradient | Linear color gradients |
| BoxShadow | Drop shadows |

## Important
Commonly used classes for intermediate Flutter development.

| Class | Description |
|-------|-------------|
| TextPainter | Low-level text rendering |
| TextScaler | Text scaling |
| TextAlignVertical | Vertical text alignment |
| RoundedRectangleBorder | Rounded rectangle shape |
| CircleBorder | Circular shape |
| StadiumBorder | Stadium/pill shape |
| BeveledRectangleBorder | Beveled corners |
| ContinuousRectangleBorder | Smooth corners |
| OvalBorder | Oval shape |
| RadialGradient | Radial color gradients |
| SweepGradient | Angular gradients |
| DecorationImage | Image in decoration |
| ShapeDecoration | Shape-based decoration |
| ImageProvider | Base image provider |
| MemoryImage | In-memory images |
| ExactAssetImage | Exact resolution assets |
| FractionalOffset | Fractional positioning |
| HSLColor | HSL color representation |
| HSVColor | HSV color representation |
| ColorSwatch | Color palette |
| StrutStyle | Line height control |

## Secondary
Specialized classes for advanced use cases.

| Class | Description |
|-------|-------------|
| BoxBorder | Base box border |
| BorderDirectional | RTL-aware border |
| OutlinedBorder | Shape with outline |
| StarBorder | Star shape |
| LinearBorder | Linear border |
| LinearBorderEdge | Linear border edge |
| RoundedSuperellipseBorder | Superellipse border |
| ShapeBorder | Base shape border |
| NotchedShape | Shape with notch |
| CircularNotchedRectangle | Notched rectangle |
| AutomaticNotchedShape | Auto-notched shape |
| GradientRotation | Gradient rotation |
| GradientTransform | Gradient transform |
| Decoration | Base decoration |
| BoxPainter | Decoration painter |
| DecorationImagePainter | Image painter |
| FlutterLogoDecoration | Flutter logo |
| ImageCache | Image caching |
| ImageCacheStatus | Cache status |
| ImageStream | Image loading stream |
| ImageStreamCompleter | Stream completion |
| ImageStreamListener | Stream listener |
| ImageInfo | Image metadata |
| ImageConfiguration | Image loading config |
| ImageChunkEvent | Loading progress |
| ResizeImage | Image resizing |
| ResizeImageKey | Resize cache key |
| PlaceholderDimensions | Inline placeholder |
| PlaceholderSpan | Inline span placeholder |
| WordBoundary | Word boundary detection |
| Gradient | Base gradient |

## Hardly Relevant
Internal/low-level classes rarely used directly.

| Class | Description |
|-------|-------------|
| Accumulator | Internal accumulation |
| AssetBundleImageKey | Asset cache key |
| AssetBundleImageProvider | Asset image base |
| ClipContext | Clipping context |
| ColorProperty | Diagnostics property |
| FittedSizes | Fitted size calculation |
| ImageSizeInfo | Image size debugging |
| ImageStreamCompleterHandle | Stream handle |
| InlineSpan | Inline text span |
| InlineSpanSemanticsInformation | Span semantics |
| MatrixUtils | Matrix utilities |
| MultiFrameImageStreamCompleter | Multi-frame images |
| NetworkImageLoadException | Network error |
| OneFrameImageStreamCompleter | Single-frame images |
| PaintingBinding | Painting binding |
| ShaderWarmUp | Shader precompilation |
| TransformProperty | Transform diagnostics |
