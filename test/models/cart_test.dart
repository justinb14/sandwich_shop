import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  final repo = PricingRepository();

  test('add sandwiches and compute totals', () {
    final cart = Cart();

    final footlongVeggie = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: true,
      breadType: BreadType.wheat,
      isToasted: false,
    );

    final sixInchTuna = Sandwich(
      type: SandwichType.tunaMelt,
      isFootlong: false,
      breadType: BreadType.white,
      isToasted: false,
    );

    // add one footlong veggie and two six-inch tuna
    cart.add(footlongVeggie);
    cart.add(sixInchTuna, 2);

    expect(cart.totalItems(), 3);

    final expected = repo.calculateTotalPrice('Footlong', 1) +
        repo.calculateTotalPrice('Six-inch', 2);

    expect(cart.totalPrice(), closeTo(expected, 0.001));

    final items = cart.getItems();
    expect(items[footlongVeggie], 1);
    expect(items[sixInchTuna], 2);
  });

  test('remove sandwiches updates counts and totals', () {
    final cart = Cart();

    final footlongVeggie = Sandwich(
      type: SandwichType.veggieDelight,
      isFootlong: true,
      breadType: BreadType.wheat,
      isToasted: false,
    );

    // add two then remove one
    cart.add(footlongVeggie, 2);
    expect(cart.totalItems(), 2);

    cart.remove(footlongVeggie);
    expect(cart.totalItems(), 1);
    expect(cart.getItems()[footlongVeggie], 1);

    final expected = repo.calculateTotalPrice('Footlong', 1);
    expect(cart.totalPrice(), closeTo(expected, 0.001));

    // remove remaining
    cart.remove(footlongVeggie);
    expect(cart.isEmpty, isTrue);
    expect(cart.totalPrice(), closeTo(0.0, 0.001));
  });
}
