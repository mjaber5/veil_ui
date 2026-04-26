import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veil_ui/src/widgets/app_dimensions.dart';
import 'package:veil_ui/src/widgets/back_leading.dart';

/// A transparent app bar with a smooth iOS 26-style gradient shadow that
/// fades content scrolling beneath it.
///
/// **Basic usage:**
/// ```dart
/// Scaffold(
///   appBar: GlassAppBar(title: 'Settings'),
///   body: ListView(...),
/// )
/// ```
///
/// **Modal sheet usage:**
/// ```dart
/// GlassAppBar(title: 'Edit', isModalSheet: true)
/// ```
///
/// **Scroll-driven shadow:**
/// ```dart
/// GlassAppBar(title: 'Feed', scrollController: _scrollController)
/// ```
class GlassAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GlassAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.height = kToolbarHeight,
    this.isModalSheet = false,
    this.onBack,
    this.showShadow = true,
    this.showLeadingButton = true,
    this.systemOverlayStyle,
    this.leadingWidth,
    this.titleTextStyle,
    this.scrollController,
    this.forceShadow,
    this.scrollThreshold = 5.0,
    this.bottom,
  });

  /// Plain-text title. Ignored when [titleWidget] is provided.
  final String? title;

  /// Fully custom title widget — takes precedence over [title].
  final Widget? titleWidget;

  /// Override the default [BackLeading] widget.
  final Widget? leading;

  /// Trailing action widgets (right side of the bar).
  final List<Widget>? actions;

  final bool centerTitle;

  /// App bar height. Defaults to [kToolbarHeight].
  final double height;

  /// When `true`, the leading icon shows × (close) instead of ‹ (back).
  final bool isModalSheet;

  /// Overrides the default [Navigator.maybePop] on the leading button.
  final VoidCallback? onBack;

  /// Show the gradient shadow overlay. Default `true`.
  final bool showShadow;

  /// Show the leading back/close button. Default `true`.
  final bool showLeadingButton;

  /// Optional status-bar style override.
  final SystemUiOverlayStyle? systemOverlayStyle;

  final double? leadingWidth;

  /// Override the default title [TextStyle].
  final TextStyle? titleTextStyle;

  /// Drives scroll-based shadow visibility. Shadow appears after
  /// [scrollThreshold] pixels of scroll offset.
  final ScrollController? scrollController;

  /// Explicitly force shadow on (`true`) or off (`false`), bypassing scroll state.
  final bool? forceShadow;

  /// Pixel offset after which the shadow becomes visible. Default `5.0`.
  final double scrollThreshold;

  /// Widget placed below the toolbar (e.g. a [TabBar]).
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
    height + (bottom?.preferredSize.height ?? 0),
  );

  @override
  State<GlassAppBar> createState() => _GlassAppBarState();
}

class _GlassAppBarState extends State<GlassAppBar> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Standard screens always show the shadow; modals wait for first scroll.
    _isScrolled = !widget.isModalSheet;
    widget.scrollController?.addListener(_onScroll);
    if (widget.scrollController?.hasClients ?? false) _onScroll();
  }

  @override
  void didUpdateWidget(GlassAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      widget.scrollController?.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = (widget.scrollController?.offset ?? 0) > widget.scrollThreshold;
    if (scrolled != _isScrolled) setState(() => _isScrolled = scrolled);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final shadowColor = theme.scaffoldBackgroundColor;
    final shadowVisible = widget.forceShadow ?? _isScrolled;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (widget.showShadow)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: widget.isModalSheet
                ? widget.height * 3.5
                : widget.height * 5.5,
            child: AnimatedOpacity(
              opacity: shadowVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              child: _GradientShadow(shadowColor: shadowColor, isDark: isDark),
            ),
          ),
        _AppBarContent(
          title: widget.title,
          titleWidget: widget.titleWidget,
          leading: widget.leading,
          actions: widget.actions,
          centerTitle: widget.centerTitle,
          height: widget.height,
          isModalSheet: widget.isModalSheet,
          onBack: widget.onBack,
          systemOverlayStyle: widget.systemOverlayStyle,
          showLeadingButton: widget.showLeadingButton,
          leadingWidth: widget.leadingWidth,
          titleTextStyle: widget.titleTextStyle,
          bottom: widget.bottom,
        ),
      ],
    );
  }
}

// ── Private widgets ───────────────────────────────────────────────────────────

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({
    required this.title,
    required this.titleWidget,
    required this.leading,
    required this.actions,
    required this.centerTitle,
    required this.height,
    required this.isModalSheet,
    required this.onBack,
    required this.systemOverlayStyle,
    required this.showLeadingButton,
    required this.titleTextStyle,
    required this.bottom,
    this.leadingWidth,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final double height;
  final bool isModalSheet;
  final VoidCallback? onBack;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool showLeadingButton;
  final double? leadingWidth;
  final TextStyle? titleTextStyle;
  final PreferredSizeWidget? bottom;

  Widget? _buildTitle(TextTheme textTheme) {
    if (titleWidget != null) return titleWidget;
    if (title != null) {
      return Text(
        title!,
        style: titleTextStyle ??
            textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: isModalSheet ? AppDimensions.textLG : AppDimensions.textXXL,
            ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      systemOverlayStyle: systemOverlayStyle,
      leading: showLeadingButton
          ? leading ?? BackLeading(isModalSheet: isModalSheet, onBack: onBack)
          : null,
      leadingWidth: leadingWidth ?? (45 + AppDimensions.spaceMD * 3),
      title: _buildTitle(theme.textTheme),
      actions: actions,
      bottom: bottom,
    );
  }
}

/// iOS 26-style gradient shadow — opaque at the top, fully transparent below.
class _GradientShadow extends StatelessWidget {
  const _GradientShadow({required this.shadowColor, required this.isDark});

  final Color shadowColor;
  final bool isDark;

  static const List<double> _stops = [
    0.00, 0.10, 0.20, 0.30, 0.40, 0.55, 0.70, 0.85, 1.00,
  ];

  List<Color> _colors(Color base) => [
    base,
    base,
    base.withValues(alpha: isDark ? 0.92 : 0.94),
    base.withValues(alpha: isDark ? 0.77 : 0.82),
    base.withValues(alpha: isDark ? 0.53 : 0.61),
    base.withValues(alpha: isDark ? 0.27 : 0.34),
    base.withValues(alpha: isDark ? 0.09 : 0.12),
    base.withValues(alpha: 0.02),
    base.withValues(alpha: 0.00),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: _stops,
          colors: _colors(shadowColor),
        ),
      ),
    );
  }
}
