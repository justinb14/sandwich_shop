import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  testWidgets('SegmentedButton toggles between Footlong and Six-inch',
      (WidgetTester tester) async {

    // Build the widget
    await tester.pumpWidget(const App());

    // --- Initial state check ---
    expect(find.text('5 Footlong sandwich(es)'), findsOneWidget);
    expect(find.text('5 Six-inch sandwich(es)'), findsNothing);

    // --- Tap the Six-inch button ---
    await tester.tap(find.text('Six-inch'));
    await tester.pumpAndSettle();

    // Should now show Six-inch
    expect(find.text('5 Six-inch sandwich(es)'), findsOneWidget);
    expect(find.text('5 Footlong sandwich(es)'), findsNothing);

    // --- Tap back to Footlong ---
    await tester.tap(find.text('Footlong'));
    await tester.pumpAndSettle();

    // Should now show Footlong again
    expect(find.text('5 Footlong sandwich(es)'), findsOneWidget);
    expect(find.text('5 Six-inch sandwich(es)'), findsNothing);
  });

  testWidgets('cart summary updates when add pressed', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // initial cart summary should be zero
    expect(find.byKey(const Key('cartSummary')), findsOneWidget);
    expect(find.text('Cart: 0 items - Total: £0.00'), findsOneWidget);

    // compute expected unit price for the default sandwich type
    final unitPrice = PricingRepository().calculateTotalPrice('Footlong', 1);

    // tap the '+ Add' button
    await tester.tap(find.text('+ Add'));
    await tester.pumpAndSettle();

    final expected = 'Cart: 1 items - Total: £${unitPrice.toStringAsFixed(2)}';
    expect(find.text(expected), findsOneWidget);
  });
}
//All tests passed "00:10 +1: All tests passed!""