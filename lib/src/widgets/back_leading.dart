import 'package:flutter/material.dart';
import 'package:veil_ui/src/helpers/ios_version_helper.dart';
import 'package:veil_ui/src/widgets/app_dimensions.dart';
import 'package:veil_ui/src/widgets/ios_button_widget.dart';

/// Transparent back button (chevron or ×) that automatically adapts to:
/// - iOS 26+ : native [IosButtonWidget] (SF Symbol via cupertino_native)
/// - iOS <26 / Android : Material circle-icon button
///
/// RTL is derived from [Localizations] — no external locale package needed.
class BackLeading extends StatelessWidget {
  const BackLeading({
    super.key,
    required this.isModalSheet,
    this.onBack,
    this.havePadding = true,
    this.containerSize,
    this.iconSize,
  });

  /// When `true` the leading icon becomes × (close) instead of a back chevron.
  final bool isModalSheet;

  /// Overrides the default [Navigator.maybePop] tap handler.
  final VoidCallback? onBack;

  final bool havePadding;
  final double? containerSize;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Standard Flutter — no easy_localization required.
    final locale = Localizations.localeOf(context);
    final isRtl = locale.languageCode == 'ar';

    final EdgeInsetsDirectional padding = EdgeInsetsDirectional.only(
      start: havePadding ? AppDimensions.screenPaddingH : 0,
    );

    // iOS 26+ — native SF Symbol button via cupertino_native.
    if (IosVersionHelper.instance.isModernIos) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: padding,
          child: IosButtonWidget(
            symbol: isModalSheet ? 'xmark' : (isRtl ? 'chevron.right' : 'chevron.left'),
            onBack: onBack ?? () => Navigator.of(context).maybePop(),
          ),
        ),
      );
    }

    // iOS <26 / Android — Material circle button.
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: padding,
        child: GestureDetector(
          onTap: onBack ?? () => Navigator.of(context).maybePop(),
          child: Container(
            width: containerSize ?? 44,
            height: containerSize ?? 44,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              shape: BoxShape.circle,
              border: Border.all(color: cs.onSurface.withValues(alpha: 0.1)),
            ),
            child: Center(
              child: Padding(
                // Optical centering for the chevron glyph.
                padding: EdgeInsetsDirectional.only(
                  end: isRtl ? 0 : 2,
                  start: isRtl ? 2 : 0,
                ),
                child: Icon(
                  isModalSheet
                      ? Icons.close
                      : (isRtl
                            ? Icons.arrow_back_ios_new_rounded
                            : Icons.arrow_back_ios_new),
                  color: cs.onSurface,
                  size: iconSize ?? 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
