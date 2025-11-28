import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  test('Sandwich name and image for footlong veggie', () {
    final s = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: true,
      breadType: BreadType.wheat,
    );
    expect(s.name, 'Veggie Delight');
    expect(s.image, 'assets/images/veggieDelight_footlong.png');
  });

  test('Sandwich name and image for six-inch tuna', () {
    final s = Sandwich(
      type: SandwichType.tunaMelt,
      isFootlong: false,
      breadType: BreadType.white,
    );
    expect(s.name, 'Tuna Melt');
    expect(s.image, 'assets/images/tunaMelt_six_inch.png');
  });
}
