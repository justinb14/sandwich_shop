import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('CheckoutScreen Widget Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
      cart.addItem(Sandwich(name: 'Ham', isFootlong: false), 2);
      cart.addItem(Sandwich(name: 'Turkey', isFootlong: true), 1);
    });

    testWidgets('renders order summary and total', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.textContaining('Ham'), findsOneWidget);
      expect(find.textContaining('Turkey'), findsOneWidget);
      expect(find.text('Total:'), findsOneWidget);
      expect(find.textContaining('£'), findsWidgets);
    });

    testWidgets('shows payment method and confirm button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      expect(find.text('Payment Method: Card ending in 1234'), findsOneWidget);
      expect(find.text('Confirm Payment'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows processing indicator after payment pressed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CheckoutScreen(cart: cart),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); // Start async
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Processing payment...'), findsOneWidget);
    });
  });
}
