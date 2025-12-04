class PricingRepository {
  // Example price map
  static const Map<String, double> basePrices = {
    'footlong': 6.0,
    'six-inch': 3.5,
  };

  double calculateTotalPrice(String size, int quantity) {
    // Defensive: ensure size is valid
    if (!basePrices.containsKey(size)) {
      throw ArgumentError('Invalid size: $size');
    }
    final double pricePerItem = basePrices[size]!;
    return pricePerItem * quantity;
  }
}
