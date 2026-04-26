import 'package:flutter/material.dart';

/// Wraps [child] in a [Stack] and renders a gradient overlay at the bottom
/// (or top when [inverseGradient] is `true`) with an optional fixed widget
/// above it.
///
/// The gradient colour is derived from [Theme.scaffoldBackgroundColor] so it
/// matches the host app's background automatically — including dark mode.
///
/// **Typical usage — scrollable list with a sticky CTA:**
/// ```dart
/// BlurredBottomOverlay(
///   child: ListView(...),
///   bottomWidget: Padding(
///     padding: EdgeInsets.all(16),
///     child: ElevatedButton(onPressed: ..., child: Text('Continue')),
///   ),
/// )
/// ```
///
/// **Custom colour (e.g. inside a card):**
/// ```dart
/// BlurredBottomOverlay(
///   overlayColor: Colors.white,
///   child: ...,
///   bottomWidget: ...,
/// )
/// ```
class BlurredBottomOverlay extends StatelessWidget {
  const BlurredBottomOverlay({
    super.key,
    required this.child,
    this.bottomWidget,
    this.inverseGradient = false,
    this.useSafeArea = true,
    this.overlayColor,
    this.gradientHeight,
  });

  final Widget child;

  /// Widget pinned above the gradient (e.g. a button or nav bar).
  final Widget? bottomWidget;

  /// `false` (default): transparent → opaque (bottom fade-out).
  /// `true`: opaque → transparent (top fade-in).
  final bool inverseGradient;

  /// Wrap [bottomWidget] in [SafeArea] to respect the home indicator. Default `true`.
  final bool useSafeArea;

  /// Override the gradient colour. Defaults to [ThemeData.scaffoldBackgroundColor].
  final Color? overlayColor;

  /// Override the height of the gradient overlay region.
  /// Defaults to the intrinsic height of [bottomWidget].
  final double? gradientHeight;

  static const List<double> _stops = <double>[
    0.00, 0.05, 0.10, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95, 1.00,
  ];

  List<Color> _buildColors(Color base) {
    final alphas = inverseGradient
        ? <double>[1.00, 0.95, 0.90, 0.85, 0.75, 0.65, 0.55, 0.45, 0.35, 0.25, 0.15, 0.05, 0.00]
        : <double>[0.00, 0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.90, 0.95, 1.00];

    return alphas.map((a) => base.withValues(alpha: a)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (bottomWidget == null) return child;

    final Color base = overlayColor ?? Theme.of(context).scaffoldBackgroundColor;

    final Widget overlay = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: _stops,
          colors: _buildColors(base),
        ),
      ),
      child: useSafeArea
          ? SafeArea(top: false, child: bottomWidget!)
          : bottomWidget!,
    );

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        child,
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: gradientHeight,
          child: overlay,
        ),
      ],
    );
  }
}
