import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:veil_ui/src/widgets/app_dimensions.dart';

/// Native iOS button using an SF Symbol glyph via [cupertino_native].
///
/// Only rendered on iOS 26+ — [BackLeading] gates usage behind
/// [IosVersionHelper.instance.isModernIos].
class IosButtonWidget extends StatelessWidget {
  const IosButtonWidget({
    super.key,
    required this.symbol,
    required this.onBack,
    this.label,
    this.opacity = 0.5,
    this.hasBadge = false,
  });

  /// SF Symbol name, e.g. `'chevron.left'`, `'xmark'`.
  final String symbol;
  final VoidCallback? onBack;
  final String? label;
  final double opacity;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) {
    return CNButton.icon(
      size: AppDimensions.iconXL - 4,
      icon: CNSymbol(symbol, size: AppDimensions.iconXS + 2),
      onPressed: onBack,
    );
  }
}
