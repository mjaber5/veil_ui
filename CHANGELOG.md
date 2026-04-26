# Changelog

All notable changes to this project will be documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.3] - 2026-04-26

### Fixed
- README: removed broken GIF reference (replaced with video link).
- CHANGELOG: added missing `0.0.2` entry so pub.dev validation passes.

## [0.0.2] - 2026-04-26

### Changed
- README: added demo video via GitHub CDN and light/dark mode toggle example.
- `.pubignore`: excluded `android/`, `ios/`, and `assets/demo.mov` from the published package.

## [0.0.1] - 2026-04-26

### Added
- `GlassAppBar` — transparent app bar with iOS 26-style gradient shadow.
  - Scroll-driven shadow reveal via optional `ScrollController`.
  - `forceShadow` override for parent-driven control.
  - `titleWidget` support for fully custom titles.
  - `bottom` slot for `TabBar` and other `PreferredSizeWidget`s.
  - Configurable `scrollThreshold`, `titleTextStyle`, and `leadingWidth`.
  - Modal-sheet mode (`isModalSheet: true`) shows × instead of ‹.
- `BlurredBottomOverlay` — gradient fade-out over scrollable content.
  - `overlayColor` override (defaults to scaffold background).
  - `gradientHeight` for explicit sizing.
  - `inverseGradient` for top-fade use cases.
  - `useSafeArea` toggle for home-indicator spacing.
- `BackLeading` — adaptive back/close button.
  - iOS 26+: native SF Symbol via `cupertino_native`.
  - iOS <26 / Android: Material circle button.
  - RTL-aware (uses `Localizations`, no third-party locale package).
- `IosVersionHelper` — lightweight iOS version cache.
  - Plain singleton — no service-locator dependency.
  - `setMockVersion` for unit testing.
- `AppDimensions` — static spacing, text, radius, and icon tokens.
