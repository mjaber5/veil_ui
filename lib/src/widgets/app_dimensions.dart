/// Static sizing tokens used by veil_ui widgets.
///
/// All values are raw [double]s — no screen-util dependency.
/// Apply `.h` / `.w` / `.sp` at the call site if your app uses screen-util.
abstract final class AppDimensions {
  // ── Spacing ───────────────────────────────────────────────────────────────
  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;

  // ── Text sizes ────────────────────────────────────────────────────────────
  static const double textXXS = 8.0;
  static const double textXS = 10.0;
  static const double textSM = 12.0;
  static const double textMD = 14.0;
  static const double textLG = 16.0;
  static const double textXL = 18.0;
  static const double textXXL = 20.0;
  static const double textTitle = 24.0;
  static const double textHeadline = 28.0;

  // ── Border radius ─────────────────────────────────────────────────────────
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCard = 32.0;
  static const double radiusPill = 100.0;

  // ── Component sizes ───────────────────────────────────────────────────────
  static const double cardPadding = 16.0;
  static const double cardRadius = 20.0;
  static const double cardBorderWidth = 1.0;

  static const double buttonHeight = 56.0;
  static const double buttonHeightSmall = 44.0;
  static const double buttonRadius = 28.0;
  static const double buttonPaddingH = 24.0;

  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;

  static const double avatarXS = 24.0;
  static const double avatarSM = 32.0;
  static const double avatarMD = 48.0;
  static const double avatarLG = 64.0;
  static const double avatarXL = 96.0;
  static const double avatarXXL = 120.0;

  static const double bottomNavHeight = 80.0;
  static const double navPillHeight = 64.0;
  static const double navIconSize = 28.0;
  static const double glassBlur = 12.0;
  static const double fabSize = 56.0;

  static const double actionTileSize = 80.0;
  static const double actionTileIconSize = 40.0;

  // ── Screen padding ────────────────────────────────────────────────────────
  static const double screenPaddingH = 20.0;
  static const double screenPaddingV = 16.0;
}
