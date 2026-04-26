import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// Caches the iOS major version so widgets never issue redundant async
/// platform calls during build.
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

  /// Reads the system version from [DeviceInfoPlugin] and caches it.
  /// Safe to call multiple times — subsequent calls are no-ops.
  Future<void> init() async {
    if (!kIsWeb && Platform.isIOS) {
      final info = await DeviceInfoPlugin().iosInfo;
      final raw = info.systemVersion.split('.').first;
      _majorVersion = int.tryParse(raw) ?? 0;
    }
  }

  /// Override for unit tests — never call in production code.
  @visibleForTesting
  void setMockVersion(int version) => _majorVersion = version;
}
