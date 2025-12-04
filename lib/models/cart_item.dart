import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, required this.quantity});

  double get itemSubtotal {
    // Fix: Pass the correct type for the first argument (size as String, not bool)
    // Assuming PricingRepository().calculateTotalPrice(String size, int quantity)
    // where size is 'footlong' or 'six-inch'
    final String size = sandwich.isFootlong ? 'footlong' : 'six-inch';
    return PricingRepository().calculateTotalPrice(
      size,
      quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItem &&
          runtimeType == other.runtimeType &&
          sandwich == other.sandwich;

  @override
  int get hashCode => sandwich.hashCode;
}
