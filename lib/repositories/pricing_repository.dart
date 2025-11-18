class PricingRepository {
  final double sixInchPrice = 7.0;
  final double footlongPrice = 11.0;

  double calculateTotalPrice(String sandwichType, int quantity) {
    if (sandwichType == 'Six-inch') {
      return sixInchPrice * quantity;
    } else if (sandwichType == 'Footlong') {
      return footlongPrice * quantity;
    } else {
      throw ArgumentError('Invalid sandwich type: $sandwichType');
    }
  }
}
