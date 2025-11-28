import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  testWidgets('SegmentedButton toggles and affects cart totals', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // compute prices
    final footlongPrice = PricingRepository().calculateTotalPrice('Footlong', 1);
    final sixInchPrice = PricingRepository().calculateTotalPrice('Six-inch', 1);

    // add one Footlong
    await tester.tap(find.byKey(const Key('addToCart')));
    await tester.pumpAndSettle();
    expect(find.text('Cart: 1 items - Total: £${footlongPrice.toStringAsFixed(2)}'), findsOneWidget);

    // select Six-inch and add one
    await tester.tap(find.text('Six-inch'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('addToCart')));
    await tester.pumpAndSettle();

    final combined = footlongPrice + sixInchPrice;
    expect(find.text('Cart: 2 items - Total: £${combined.toStringAsFixed(2)}'), findsOneWidget);
  });

  testWidgets('cart summary updates when add pressed', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // initial cart summary should be zero
    expect(find.byKey(const Key('cartSummary')), findsOneWidget);
    expect(find.text('Cart: 0 items - Total: £0.00'), findsOneWidget);

    // compute expected unit price for the default sandwich type
    final unitPrice = PricingRepository().calculateTotalPrice('Footlong', 1);

    // tap the 'Add to Cart' button
    await tester.tap(find.byKey(const Key('addToCart')));
    await tester.pumpAndSettle();

    final expected = 'Cart: 1 items - Total: £${unitPrice.toStringAsFixed(2)}';
    expect(find.text(expected), findsOneWidget);
  });

  testWidgets('cart summary updates when add pressed and then remove pressed', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // initial cart summary should be zero
    expect(find.byKey(const Key('cartSummary')), findsOneWidget);
    expect(find.text('Cart: 0 items - Total: £0.00'), findsOneWidget);

    // tap the 'Add to Cart' button
    await tester.tap(find.byKey(const Key('addToCart')));
    await tester.pumpAndSettle();

    final unitPrice = PricingRepository().calculateTotalPrice('Footlong', 1);
    final expectedAfterAdd = 'Cart: 1 items - Total: £${unitPrice.toStringAsFixed(2)}';
    expect(find.text(expectedAfterAdd), findsOneWidget);

    // tap the 'Remove one' button to remove the item from the cart
    await tester.tap(find.byKey(const Key('removeFromCart')));
    await tester.pumpAndSettle();

    // cart should be back to zero
    expect(find.text('Cart: 0 items - Total: £0.00'), findsOneWidget);
  });

  testWidgets('add two items by pressing Add twice and view cart page', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // add two Footlong (default) by pressing Add twice
    await tester.tap(find.byKey(const Key('addToCart')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('addToCart')));
    await tester.pumpAndSettle();

    final unitTotal = PricingRepository().calculateTotalPrice('Footlong', 2);
    final expectedSummary = 'Cart: 2 items - Total: £${unitTotal.toStringAsFixed(2)}';
    expect(find.text(expectedSummary), findsOneWidget);

    // open View Cart (navigates to CartPage) and check page content
    await tester.tap(find.byKey(const Key('viewCart')));
    await tester.pumpAndSettle();

    // CartPage should show the per-item line with toast state (default untoasted)
    expect(find.textContaining('Footlong (untoasted) x 2'), findsOneWidget);
    // total should be visible with the CartPage key
    expect(find.byKey(const Key('cartPageTotal')), findsOneWidget);
    expect(find.text('Total: £${unitTotal.toStringAsFixed(2)}'), findsOneWidget);
  });
}
//All tests passed "00:10 +1: All tests passed!""