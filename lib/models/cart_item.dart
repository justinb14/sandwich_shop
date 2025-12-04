import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, required this.quantity});

  double get itemSubtotal {
    return PricingRepository().calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
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
