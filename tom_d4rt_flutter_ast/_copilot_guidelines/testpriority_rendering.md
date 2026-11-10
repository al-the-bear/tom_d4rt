# Test Priority: rendering

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core rendering classes used in most Flutter applications.

| Class | Description |
|-------|-------------|
| RenderBox | Box layout model - fundamental |
| RenderObject | Base render object |
| BoxConstraints | Box layout constraints |
| RenderFlex | Flex layout (Row/Column) |
| RenderStack | Stack layout |
| RenderPadding | Padding render |
| RenderPositionedBox | Alignment render |
| RenderConstrainedBox | Constrained render |
| RenderDecoratedBox | Decorated render |
| PaintingContext | Painting context |
| BoxParentData | Box parent data |
| Layer | Base layer |
| ContainerLayer | Layer container |
| OffsetLayer | Offset layer |
| PipelineOwner | Render pipeline |
| ViewConfiguration | View config |
| ViewportOffset | Scroll offset |

## Important
Commonly used rendering classes.

| Class | Description |
|-------|-------------|
| RenderProxyBox | Proxy render box |
| RenderOpacity | Opacity render |
| RenderTransform | Transform render |
| RenderClipRect | Clip rect |
| RenderClipRRect | Clip rounded rect |
| RenderClipOval | Clip oval |
| RenderClipPath | Clip path |
| RenderImage | Image render |
| RenderParagraph | Text render |
| RenderShiftedBox | Shifted box |
| RenderAspectRatio | Aspect ratio |
| RenderFittedBox | Fitted box |
| RenderLimitedBox | Limited box |
| RenderIntrinsicWidth | Intrinsic width |
| RenderIntrinsicHeight | Intrinsic height |
| RenderWrap | Wrap layout |
| RenderTable | Table layout |
| RenderFlow | Flow layout |
| RenderListBody | List body |
| RenderView | Root view |
| RenderViewport | Scroll viewport |
| RenderSliver | Base sliver |
| RenderSliverList | Sliver list |
| RenderSliverGrid | Sliver grid |
| RenderSliverPadding | Sliver padding |
| RenderSliverOpacity | Sliver opacity |
| SliverConstraints | Sliver constraints |
| SliverGeometry | Sliver geometry |
| SliverGridDelegate | Grid delegate |
| SliverGridDelegateWithFixedCrossAxisCount | Fixed count grid |
| SliverGridDelegateWithMaxCrossAxisExtent | Max extent grid |
| OpacityLayer | Opacity layer |
| TransformLayer | Transform layer |
| ClipRectLayer | Clip rect layer |
| ClipRRectLayer | Clip rounded layer |
| ImageFilterLayer | Image filter layer |
| BackdropFilterLayer | Backdrop filter |
| RelativeRect | Relative positioning |
| CustomPainter | Custom painting |
| CustomClipper | Custom clipping |
| SingleChildLayoutDelegate | Single layout |
| MultiChildLayoutDelegate | Multi layout |
| FlowDelegate | Flow layout delegate |
| StackParentData | Stack parent data |
| FlexParentData | Flex parent data |
| SliverGridParentData | Grid parent data |
| TableColumnWidth | Table column width |
| FixedColumnWidth | Fixed column |
| FlexColumnWidth | Flex column |
| IntrinsicColumnWidth | Intrinsic column |

## Secondary
Specialized rendering classes.

| Class | Description |
|-------|-------------|
| RenderAbsorbPointer | Absorb pointer |
| RenderIgnorePointer | Ignore pointer |
| RenderOffstage | Offstage |
| RenderRepaintBoundary | Repaint boundary |
| RenderAnimatedSize | Animated size |
| RenderAnimatedOpacity | Animated opacity |
| RenderPhysicalModel | Physical model |
| RenderPhysicalShape | Physical shape |
| RenderShaderMask | Shader mask |
| RenderBackdropFilter | Backdrop filter |
| RenderMouseRegion | Mouse region |
| RenderPointerListener | Pointer listener |
| RenderSemanticsAnnotations | Semantics |
| RenderSemanticsGestureHandler | Gesture semantics |
| RenderMergeSemantics | Merge semantics |
| RenderExcludeSemantics | Exclude semantics |
| RenderBlockSemantics | Block semantics |
| RenderIndexedSemantics | Indexed semantics |
| RenderRotatedBox | Rotated box |
| RenderBaseline | Baseline |
| RenderIgnoreBaseline | Ignore baseline |
| RenderFractionallySizedOverflowBox | Fractional overflow |
| RenderFractionalTranslation | Fractional translation |
| RenderSizedOverflowBox | Sized overflow |
| RenderConstrainedOverflowBox | Constrained overflow |
| RenderConstraintsTransformBox | Constraints transform |
| RenderCustomPaint | Custom paint render |
| RenderCustomSingleChildLayoutBox | Custom single layout |
| RenderCustomMultiChildLayoutBox | Custom multi layout |
| RenderListWheelViewport | Wheel viewport |
| RenderEditable | Editable text |
| RenderAnnotatedRegion | Annotated region |
| RenderFollowerLayer | Follower layer |
| RenderLeaderLayer | Leader layer |
| RenderMetaData | Meta data |
| RenderIndexedStack | Indexed stack |
| RenderErrorBox | Error display |
| RenderSliverFixedExtentList | Fixed extent list |
| RenderSliverVariedExtentList | Varied extent list |
| RenderSliverFillViewport | Fill viewport |
| RenderSliverFillRemaining | Fill remaining |
| RenderSliverToBoxAdapter | Box adapter |
| RenderSliverPersistentHeader | Persistent header |
| RenderSliverFloatingPersistentHeader | Floating header |
| RenderSliverPinnedPersistentHeader | Pinned header |
| RenderSliverScrollingPersistentHeader | Scrolling header |
| RenderSliverMultiBoxAdaptor | Multi box adaptor |
| RenderSliverAnimatedOpacity | Animated opacity |
| RenderSliverOffstage | Sliver offstage |
| RenderSliverIgnorePointer | Sliver ignore |
| RenderShrinkWrappingViewport | Shrink viewport |
| RenderViewportBase | Viewport base |
| RenderTreeSliver | Tree sliver |
| SelectionGeometry | Selection geometry |
| SelectionPoint | Selection point |
| SelectedContent | Selected content |
| SelectionRegistrar | Selection registrar |
| Selectable | Selectable interface |
| LayerLink | Layer linking |
| LayerHandle | Layer handle |
| LeaderLayer | Leader layer |
| FollowerLayer | Follower layer |
| ClipPathLayer | Clip path layer |
| ClipRSuperellipseLayer | Superellipse clip |
| ColorFilterLayer | Color filter layer |
| ShaderMaskLayer | Shader mask layer |
| PictureLayer | Picture layer |
| TextureLayer | Texture layer |
| PlatformViewLayer | Platform view layer |
| PerformanceOverlayLayer | Performance overlay |
| MouseTracker | Mouse tracking |
| BoxHitTestResult | Box hit test |
| BoxHitTestEntry | Box hit entry |
| SliverHitTestResult | Sliver hit test |
| SliverHitTestEntry | Sliver hit entry |
| RenderProxyBoxMixin | Proxy mixin |
| RenderProxyBoxWithHitTestBehavior | Proxy with behavior |
| RenderAligningShiftedBox | Aligning shifted |
| ParentData | Base parent data |
| ContainerBoxParentData | Container box data |
| ListBodyParentData | List body data |
| ListWheelParentData | Wheel parent data |
| WrapParentData | Wrap parent data |
| TableCellParentData | Table cell data |
| TextParentData | Text parent data |
| SliverLogicalParentData | Logical sliver data |
| SliverPhysicalParentData | Physical sliver data |
| SliverGridGeometry | Grid geometry |
| SliverGridLayout | Grid layout |
| SliverGridRegularTileLayout | Regular tile layout |
| SliverLayoutDimensions | Layout dimensions |
| SliverMultiBoxAdaptorParentData | Multi box data |
| RenderBoxContainerDefaultsMixin | Container defaults |
| ContainerRenderObjectMixin | Container mixin |
| RenderObjectWithChildMixin | Child mixin |
| DebugOverflowIndicatorMixin | Overflow debug |
| RelayoutWhenSystemFontsChangeMixin | Font relayout |
| KeepAliveParentDataMixin | Keep alive data |
| RenderSliverWithKeepAliveMixin | Keep alive sliver |
| RenderSliverHelpers | Sliver helpers |
| SemanticsAnnotationsMixin | Semantics mixin |
| RendererBinding | Renderer binding |
| RenderingFlutterBinding | Flutter binding |
| CustomPainterSemantics | Painter semantics |
| ShapeBorderClipper | Shape clipper |
| Constraints | Base constraints |
| TextSelectionPoint | Selection point |

## Hardly Relevant
Internal/low-level rendering classes.

| Class | Description |
|-------|-------------|
| PipelineManifold | Pipeline manifold |
| RenderObjectWithLayoutCallbackMixin | Layout callback |
| RenderAbstractViewport | Abstract viewport |
| RenderProxySliver | Proxy sliver |
| RenderSliverBoxChildManager | Box child manager |
| RenderSliverEdgeInsetsPadding | Edge insets padding |
| RenderSliverSingleBoxAdapter | Single box adapter |
| RenderSliverFillRemainingWithScrollable | Scrollable remaining |
| RenderSliverFillRemainingAndOverscroll | Overscroll remaining |
| RenderSliverFixedExtentBoxAdaptor | Fixed extent adaptor |
| RenderSliverConstrainedCrossAxis | Constrained cross |
| RenderSliverCrossAxisGroup | Cross axis group |
| RenderSliverMainAxisGroup | Main axis group |
| RenderSliverFloatingPinnedPersistentHeader | Floating pinned |
| RenderSliverSemanticsAnnotations | Sliver semantics |
| RenderAndroidView | Android view |
| RenderUiKitView | iOS view |
| RenderAppKitView | macOS view |
| RenderDarwinPlatformView | Darwin view |
| PlatformViewRenderBox | Platform view box |
| TextureBox | Texture box |
| RenderEditablePainter | Editable painter |
| RenderInlineChildrenContainerDefaults | Inline defaults |
| ListWheelChildManager | Wheel manager |
| SelectionHandler | Selection handler |
| SelectionRegistrant | Selection registrant |
| SelectionUtils | Selection utils |
| SelectionEvent | Selection event |
| SelectAllSelectionEvent | Select all |
| ClearSelectionEvent | Clear selection |
| SelectWordSelectionEvent | Select word |
| SelectParagraphSelectionEvent | Select paragraph |
| SelectionEdgeUpdateEvent | Edge update |
| DirectionallyExtendSelectionEvent | Directional extend |
| GranularlyExtendSelectionEvent | Granular extend |
| SelectedContentRange | Content range |
| AnnotatedRegionLayer | Annotated layer |
| AnnotationEntry | Annotation entry |
| AnnotationResult | Annotation result |
| BackdropKey | Backdrop key |
| RevealedOffset | Revealed offset |
| FloatingHeaderSnapConfiguration | Header snap config |
| OverScrollHeaderStretchConfiguration | Stretch config |
| PersistentHeaderShowOnScreenConfiguration | Show on screen |
| FlowPaintingContext | Flow context |
| FlowParentData | Flow parent data |
| TreeSliverIndentationType | Tree indent |
| TreeSliverNodeParentData | Tree node data |
| VerticalCaretMovementRun | Caret movement |
| TableBorder | Table border |
| MinColumnWidth | Min column |
| MaxColumnWidth | Max column |
| FractionColumnWidth | Fraction column |
| PlaceholderSpanIndexSemanticsTag | Placeholder tag |
| RenderClipRSuperellipse | Clip superellipse |
| SliverLogicalContainerParentData | Logical container |
| SliverPhysicalContainerParentData | Physical container |
| ChildLayoutHelper | Layout helper |
| AlignmentGeometryTween | Alignment tween |
| AlignmentTween | Alignment tween |
| FractionalOffsetTween | Offset tween |
| ImageFilterConfig | Filter config |
| ImageFilterContext | Filter context |
| DiagnosticsDebugCreator | Debug creator |
