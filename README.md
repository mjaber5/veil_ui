# veil_ui

iOS 26-style glass app bar and blurred bottom overlay for Flutter.
Scroll-driven shadows, dark mode aware, zero boilerplate.

[![pub.dev](https://img.shields.io/pub/v/veil_ui.svg)](https://pub.dev/packages/veil_ui)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.24-blue)](https://flutter.dev)

---

![veil_ui demo](assets/demo.gif)

https://github.com/user-attachments/assets/aca886ae-4790-40ca-aa31-32c7af5e8091

---

## Features

- **`GlassAppBar`** — transparent app bar with a smooth gradient shadow that fades content scrolling beneath it. Shadow appears on scroll, hides when at top.
- **`BlurredBottomOverlay`** — gradient fade-out over scrollable content with a pinned bottom widget (e.g. a sticky CTA button).
- **`showVeilUISheet`** — native Cupertino sheet presentation.
- **iOS 26 adaptive back button** — SF Symbol on iOS 26+, Material circle button below.
- Full **dark mode** support — all gradients are derived from the app's scaffold background color.
- RTL-aware — uses standard `Localizations`, no third-party locale package required.

---

## Installation

```yaml
dependencies:
  veil_ui: ^0.1.0
```

```dart
import 'package:veil_ui/veil_ui.dart';
```

**Initialize once** before `runApp` so the iOS version is cached:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IosVersionHelper.instance.init();
  runApp(const MyApp());
}
```

---

## Usage

### GlassAppBar

```dart
Scaffold(
  appBar: GlassAppBar(title: 'Settings'),
  body: ListView(...),
)
```

**Scroll-driven shadow** — shadow appears after the user scrolls past the threshold:

```dart
class _MyScreenState extends State<MyScreen> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        title: 'Feed',
        scrollController: _scroll,
      ),
      body: ListView.builder(
        controller: _scroll,
        itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
      ),
    );
  }
}
```

**Custom title widget:**

```dart
GlassAppBar(
  titleWidget: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      CircleAvatar(radius: 12, backgroundImage: NetworkImage(avatarUrl)),
      SizedBox(width: 8),
      Text('Mohammed'),
    ],
  ),
)
```

**With a TabBar:**

```dart
GlassAppBar(
  title: 'Explore',
  bottom: TabBar(tabs: [...]),
)
```

#### Parameters

| Parameter            | Type                    | Default              | Description                                 |
| -------------------- | ----------------------- | -------------------- | ------------------------------------------- |
| `title`              | `String?`               | —                    | Plain-text title                            |
| `titleWidget`        | `Widget?`               | —                    | Custom title, takes precedence over `title` |
| `actions`            | `List<Widget>?`         | —                    | Trailing action buttons                     |
| `centerTitle`        | `bool`                  | `true`               | Center the title                            |
| `height`             | `double`                | `kToolbarHeight`     | App bar height                              |
| `isModalSheet`       | `bool`                  | `false`              | Shows × instead of ‹                        |
| `onBack`             | `VoidCallback?`         | `Navigator.maybePop` | Override back tap                           |
| `showShadow`         | `bool`                  | `true`               | Enable gradient shadow                      |
| `showLeadingButton`  | `bool`                  | `true`               | Show back/close button                      |
| `scrollController`   | `ScrollController?`     | —                    | Drives scroll-based shadow reveal           |
| `scrollThreshold`    | `double`                | `5.0`                | Pixels before shadow appears                |
| `forceShadow`        | `bool?`                 | —                    | Override scroll state from parent           |
| `titleTextStyle`     | `TextStyle?`            | —                    | Override default title style                |
| `bottom`             | `PreferredSizeWidget?`  | —                    | Widget below toolbar (e.g. `TabBar`)        |
| `leadingWidth`       | `double?`               | —                    | Override leading area width                 |
| `systemOverlayStyle` | `SystemUiOverlayStyle?` | —                    | Status bar style override                   |

---

### BlurredBottomOverlay

```dart
BlurredBottomOverlay(
  bottomWidget: Padding(
    padding: EdgeInsets.all(16),
    child: SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: () {},
        child: Text('Continue'),
      ),
    ),
  ),
  child: ListView.builder(
    itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
  ),
)
```

**Inside a card (custom overlay colour):**

```dart
BlurredBottomOverlay(
  overlayColor: Colors.white,
  child: ...,
  bottomWidget: ...,
)
```

#### Parameters

| Parameter         | Type      | Default     | Description                                 |
| ----------------- | --------- | ----------- | ------------------------------------------- |
| `child`           | `Widget`  | required    | The scrollable content behind the overlay   |
| `bottomWidget`    | `Widget?` | —           | Widget pinned above the gradient            |
| `overlayColor`    | `Color?`  | scaffold bg | Override the gradient base colour           |
| `gradientHeight`  | `double?` | intrinsic   | Explicit gradient region height             |
| `inverseGradient` | `bool`    | `false`     | Flip direction (top fade instead of bottom) |
| `useSafeArea`     | `bool`    | `true`      | Wrap `bottomWidget` in `SafeArea`           |

---

### showVeilUISheet

Native Cupertino modal sheet — matches the iOS 26 card-stack presentation.

```dart
showVeilUISheet<void>(
  context: context,
  builder: (context) => const MySheetContent(),
);
```

Inside the sheet, use `GlassAppBar` with `isModalSheet: true`:

```dart
class MySheetContent extends StatelessWidget {
  const MySheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlassAppBar(
        title: 'Edit Profile',
        isModalSheet: true,
      ),
      body: ...,
    );
  }
}
```

---

## License

[MIT](LICENSE) © 2026 Mohammed Jaber
