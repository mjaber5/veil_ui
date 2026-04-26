import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';

/// Wrapper for Flutter's showCupertinoSheet with Veil naming convention
Future<T?> showVeilUISheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useNestedNavigation = false,
  bool enableDrag = true,
}) {
  return cupertino.showCupertinoSheet<T>(
    context: context,
    enableDrag: enableDrag,
    useNestedNavigation: useNestedNavigation,
    builder: builder,
  );
}
