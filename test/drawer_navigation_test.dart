import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import 'package:sandwich_shop/views/cart_screen.dart';

void main() {
  testWidgets('Drawer opens and contains navigation links', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

    // Open the Drawer
    final ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Check for Drawer header and navigation links
    expect(find.text('Sandwich Shop'), findsOneWidget);
    expect(find.text('Order'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Drawer navigation to About and Cart screens', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (context) => const ProfileScreen(),
          '/about': (context) => const AboutScreen(),
          '/cart': (context) => CartScreen(),
        },
        initialRoute: '/',
      ),
    );

    // Open the Drawer
    final ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Tap About link
    await tester.tap(find.widgetWithText(ListTile, 'About'));
    await tester.pumpAndSettle();
    expect(find.text('About Us'), findsOneWidget);

    // Go back and open Drawer again
    Navigator.of(tester.element(find.byType(AboutScreen))).pop();
    await tester.pumpAndSettle();
    final ScaffoldState scaffoldState2 = tester.firstState(find.byType(Scaffold));
    scaffoldState2.openDrawer();
    await tester.pumpAndSettle();

    // Tap Cart link
    await tester.tap(find.widgetWithText(ListTile, 'Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Your Cart'), findsOneWidget);
  });
}
