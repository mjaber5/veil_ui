import 'package:flutter/material.dart';
import 'package:veil_ui/veil_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IosVersionHelper.instance.init();
  runApp(const VeilUiExampleApp());
}

// ── App root — owns ThemeMode state ──────────────────────────────────────────

class VeilUiExampleApp extends StatefulWidget {
  const VeilUiExampleApp({super.key});

  @override
  State<VeilUiExampleApp> createState() => _VeilUiExampleAppState();
}

class _VeilUiExampleAppState extends State<VeilUiExampleApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'veil_ui Example',
      themeMode: _themeMode,
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
      home: ExampleHome(onToggleTheme: _toggleTheme, themeMode: _themeMode),
    );
  }
}

// ── Home ──────────────────────────────────────────────────────────────────────

class ExampleHome extends StatelessWidget {
  const ExampleHome({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'veil_ui',
        showLeadingButton: false,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.view_agenda_outlined),
            title: const Text('GlassAppBar — standard'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (_) => const StandardScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.table_rows_outlined),
            title: const Text('GlassAppBar — modal sheet'),
            onTap: () => showVeilUISheet<void>(
              context: context,
              builder: (_) => const ModalSheetScreen(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.layers_outlined),
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
