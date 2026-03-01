# Test Priority: dart:ui

**Total classes: 102**

## Essential (17 classes)
Core classes used in virtually every Flutter application.

| Class | Description |
|-------|-------------|
| Color | Color representation - fundamental to all styling |
| Offset | 2D point - used everywhere for positioning |
| Size | Width/height dimensions - layout fundamentals |
| Rect | Rectangle geometry - layout and rendering |
| RRect | Rounded rectangle - common UI element |
| Radius | Corner radius - rounded corners |
| Paint | Drawing style/color - all custom painting |
| Path | Vector paths - shapes and clipping |
| Canvas | Drawing surface - custom painting |
| Image | Bitmap images - displaying images |
| TextStyle | Text styling - all text rendering |
| Paragraph | Text layout - text rendering |
| ParagraphBuilder | Text construction - building text |
| Locale | Language/region - internationalization |
| FontWeight | Text weight - typography |
| Shadow | Drop shadows - visual effects |
| Gradient | Color gradients - backgrounds and fills |

## Important (23 classes)
Commonly used classes for intermediate Flutter development.

| Class | Description |
|-------|-------------|
| ParagraphStyle | Paragraph formatting |
| ParagraphConstraints | Text layout constraints |
| StrutStyle | Line height control |
| TextBox | Text measurement |
| TextDecoration | Underline/strikethrough |
| TextHeightBehavior | Line height behavior |
| TextPosition | Cursor position in text |
| TextRange | Text selection range |
| ColorFilter | Color transformations |
| ImageFilter | Blur and matrix effects |
| MaskFilter | Blur effects |
| Shader | Custom shaders |
| ImageShader | Image-based shaders |
| Picture | Recorded drawing commands |
| PictureRecorder | Recording canvas operations |
| Vertices | Custom vertex drawing |
| FontFeature | OpenType font features |
| FontVariation | Variable font axes |
| LineMetrics | Text line measurements |
| GlyphInfo | Individual glyph data |
| RSTransform | Rotation/scale transform |
| Tangent | Path tangent info |
| ViewPadding | Safe area insets |

## Secondary (35 classes)
Specialized classes for advanced use cases.

| Class | Description |
|-------|-------------|
| SceneBuilder | Scene graph construction |
| Scene | Rendered scene |
| PathMetrics | Path measurement |
| PathMetric | Individual path segment |
| PathMetricIterator | Path iteration |
| OffsetBase | Base class for Offset |
| RSuperellipse | Superellipse shapes |
| PlatformDispatcher | Platform events |
| FlutterView | View abstraction |
| GestureSettings | Gesture configuration |
| ViewConstraints | View size constraints |
| ViewFocusEvent | Focus events |
| Display | Display information |
| DisplayFeature | Screen cutouts/folds |
| FrameTiming | Frame performance |
| FrameInfo | Frame metadata |
| FrameData | Frame data |
| KeyData | Keyboard events |
| PointerData | Touch/mouse events |
| PointerDataPacket | Batched pointer events |
| SemanticsAction | Accessibility actions |
| SemanticsActionEvent | Accessibility events |
| SemanticsFlag | Accessibility flags |
| SemanticsFlags | Accessibility flag set |
| SemanticsUpdate | Accessibility updates |
| SemanticsUpdateBuilder | Building accessibility |
| StringAttribute | Text attributes |
| SpellOutStringAttribute | Spell-out attribute |
| LocaleStringAttribute | Locale attribute |
| Codec | Image codec |
| ImageDescriptor | Image metadata |
| ImmutableBuffer | Immutable byte buffer |
| TargetImageSize | Image sizing |
| AccessibilityFeatures | Accessibility settings |
| SystemColor | System color access |

## Hardly Relevant (27 classes)
Internal/low-level classes rarely used directly.

| Class | Description |
|-------|-------------|
| EngineLayer | Base engine layer |
| BackdropFilterEngineLayer | Backdrop filter layer |
| ClipPathEngineLayer | Clip path layer |
| ClipRectEngineLayer | Clip rect layer |
| ClipRRectEngineLayer | Clip rounded rect layer |
| ClipRSuperellipseEngineLayer | Clip superellipse layer |
| ColorFilterEngineLayer | Color filter layer |
| ImageFilterEngineLayer | Image filter layer |
| OffsetEngineLayer | Offset layer |
| OpacityEngineLayer | Opacity layer |
| ShaderMaskEngineLayer | Shader mask layer |
| TransformEngineLayer | Transform layer |
| CallbackHandle | Callback registration |
| ChannelBuffers | Platform channel buffers |
| DartPluginRegistrant | Plugin registration |
| FragmentProgram | Fragment shader program |
| FragmentShader | Fragment shader instance |
| UniformFloatSlot | Shader uniform slot |
| UniformVec2Slot | Shader vec2 slot |
| UniformVec3Slot | Shader vec3 slot |
| UniformVec4Slot | Shader vec4 slot |
| ImageSamplerSlot | Shader image sampler |
| IsolateNameServer | Isolate communication |
| PluginUtilities | Plugin utilities |
| RootIsolateToken | Root isolate token |
| PictureRasterizationException | Picture error |
| SystemColorPalette | System color palette |

## Summary

| Priority | Count | Percentage |
|----------|-------|------------|
| Essential | 17 | 16.7% |
| Important | 23 | 22.5% |
| Secondary | 35 | 34.3% |
| Hardly Relevant | 27 | 26.5% |
| **Total** | **102** | **100%** |
