import 'package:flutter/material.dart';
import 'package:veil_ui/veil_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize once — caches the iOS version for the lifetime of the app.
  await IosVersionHelper.instance.init();
  runApp(const VeilUiExampleApp());
}

class VeilUiExampleApp extends StatelessWidget {
  const VeilUiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'veil_ui Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6366F1)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text('GlassAppBar — standard'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const StandardScreen()),
            ),
          ),
          ListTile(
            title: const Text('GlassAppBar — modal sheet'),
            onTap: () => showVeilUISheet<void>(
              context: context,
              builder: (_) => const ModalSheetScreen(),
            ),
          ),
          ListTile(
            title: const Text('BlurredBottomOverlay — sticky CTA'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const OverlayScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

// ── GlassAppBar — standard scrollable screen ─────────────────────────────────

class StandardScreen extends StatefulWidget {
  const StandardScreen({super.key});

  @override
  State<StandardScreen> createState() => _StandardScreenState();
}

class _StandardScreenState extends State<StandardScreen> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        showShadow: true,
        title: 'Standard Screen',
        scrollController: _scroll,
      ),
      body: ListView.builder(
        controller: _scroll,
        itemCount: 40,
        itemBuilder: (_, i) => ListTile(title: Text('Item ${i + 1}')),
      ),
    );
  }
}

// ── GlassAppBar — modal sheet ────────────────────────────────────────────────

class ModalSheetScreen extends StatefulWidget {
  const ModalSheetScreen({super.key});

  @override
  State<ModalSheetScreen> createState() => _ModalSheetScreenState();
}

class _ModalSheetScreenState extends State<ModalSheetScreen> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(
          title: 'Edit Profile',
          isModalSheet: true,
          scrollController: _scroll,
        ),
        body: ListView.builder(
          controller: _scroll,
          itemCount: 20,
          itemBuilder: (_, i) => ListTile(title: Text('Field ${i + 1}')),
        ),
      ),
    );
  }
}

// ── BlurredBottomOverlay — sticky CTA button ─────────────────────────────────

class OverlayScreen extends StatelessWidget {
  const OverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const GlassAppBar(title: 'Checkout'),
      body: BlurredBottomOverlay(
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () {},
              child: const Text('Continue'),
            ),
          ),
        ),
        child: ListView.builder(
          itemCount: 30,
          itemBuilder: (_, i) => ListTile(title: Text('Product ${i + 1}')),
        ),
      ),
    );
  }
}
