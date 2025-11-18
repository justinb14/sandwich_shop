import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart'; 

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
}
//All tests passed "00:10 +1: All tests passed!""