import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    final pricingRepository = PricingRepository();

    test('calculates total price for six-inch sandwiches', () {
      expect(pricingRepository.calculateTotalPrice('Six-inch', 3), 21.0);
    });

    test('calculates total price for footlong sandwiches', () {
      expect(pricingRepository.calculateTotalPrice('Footlong', 2), 22.0);
    });

    test('throws error for invalid sandwich type', () {
      expect(() => pricingRepository.calculateTotalPrice('Invalid', 1), throwsArgumentError);
    });
  });
}
