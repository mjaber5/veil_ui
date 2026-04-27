import 'dart:io';

import 'package:flutter/foundation.dart';

/// Caches the iOS major version so widgets never parse the system string
/// on every build call.
///
/// Uses [Platform.operatingSystemVersion] — no third-party package required.
///
/// **Initialization** — call once at app startup, before [runApp]:
/// ```dart
/// await IosVersionHelper.instance.init();
/// runApp(const MyApp());
/// ```
class IosVersionHelper {
  IosVersionHelper._();

  static final IosVersionHelper instance = IosVersionHelper._();

  int _majorVersion = 0;

  /// The cached iOS major version (e.g. 16, 17, 26).
  /// Returns 0 on non-iOS platforms.
  int get majorVersion => _majorVersion;

  /// `true` when running on iOS 26 or later.
  /// Always `false` on Android / web.
  bool get isModernIos {
    if (kIsWeb) return false;
    if (!Platform.isIOS) return false;
    return _majorVersion >= 26;
  }

  /// Parses the iOS version from [Platform.operatingSystemVersion].
  /// Safe to call multiple times — subsequent calls are no-ops.
  ///
  /// [Platform.operatingSystemVersion] format: `"Version 17.0 (Build 21A329)"`
  Future<void> init() async {
    if (_majorVersion != 0) return;
    if (!kIsWeb && Platform.isIOS) {
      final raw = Platform.operatingSystemVersion;
      final match = RegExp(r'Version (\d+)').firstMatch(raw);
      _majorVersion = int.tryParse(match?.group(1) ?? '0') ?? 0;
    }
  }

  /// Override for unit tests — never call in production code.
  @visibleForTesting
  void setMockVersion(int version) => _majorVersion = version;
}
