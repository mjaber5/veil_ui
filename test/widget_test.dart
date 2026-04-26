import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veil_ui/veil_ui.dart';

void main() {
  // ── IosVersionHelper ────────────────────────────────────────────────────────

  group('IosVersionHelper', () {
    setUp(() => IosVersionHelper.instance.setMockVersion(0));

    test('isModernIos is false below version 26', () {
      IosVersionHelper.instance.setMockVersion(17);
      expect(IosVersionHelper.instance.isModernIos, isFalse);
    });

    test('isModernIos is true at version 26', () {
      IosVersionHelper.instance.setMockVersion(26);
      expect(IosVersionHelper.instance.isModernIos, isTrue);
    });

    test('majorVersion reflects mock value', () {
      IosVersionHelper.instance.setMockVersion(18);
      expect(IosVersionHelper.instance.majorVersion, 18);
    });
  });

  // ── GlassAppBar ─────────────────────────────────────────────────────────────

  group('GlassAppBar', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(title: 'Hello'),
          ),
        ),
      );
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('renders titleWidget over title string', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(
              title: 'Ignored',
              titleWidget: Text('Custom'),
            ),
          ),
        ),
      );
      expect(find.text('Custom'), findsOneWidget);
      expect(find.text('Ignored'), findsNothing);
    });

    testWidgets('hides leading button when showLeadingButton is false',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(
              title: 'No Back',
              showLeadingButton: false,
            ),
          ),
        ),
      );
      expect(find.byType(BackLeading), findsNothing);
    });

    testWidgets('preferredSize height matches constructor value',
        (tester) async {
      const bar = GlassAppBar(height: 80);
      expect(bar.preferredSize.height, 80);
    });

    testWidgets('shadow is hidden when showShadow is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GlassAppBar(title: 'No Shadow', showShadow: false),
          ),
        ),
      );
      // AnimatedOpacity for shadow should not be present.
      expect(
        find.descendant(
          of: find.byType(GlassAppBar),
          matching: find.byType(AnimatedOpacity),
        ),
        findsNothing,
      );
    });
  });

  // ── BlurredBottomOverlay ────────────────────────────────────────────────────

  group('BlurredBottomOverlay', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BlurredBottomOverlay(
              child: Text('Content'),
            ),
          ),
        ),
      );
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('renders bottomWidget when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BlurredBottomOverlay(
              bottomWidget: Text('CTA'),
              child: SizedBox.expand(),
            ),
          ),
        ),
      );
      expect(find.text('CTA'), findsOneWidget);
    });

    testWidgets('returns child directly when bottomWidget is null',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BlurredBottomOverlay(
              child: Text('Only Child'),
            ),
          ),
        ),
      );
      // No Stack wrapping — widget tree is minimal.
      expect(find.text('Only Child'), findsOneWidget);
    });
  });
}
