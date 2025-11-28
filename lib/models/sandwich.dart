enum BreadType { white, wheat, wholemeal }

enum SandwichType {
  veggieDelight,
  chickenTeriyaki,
  tunaMelt,
  meatballMarinara,
}

class Sandwich {
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;
  final bool isToasted; // new

  Sandwich({
    required this.type,
    required this.isFootlong,
    required this.breadType,
    this.isToasted = false,
  });

  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.chickenTeriyaki:
        return 'Chicken Teriyaki';
      case SandwichType.tunaMelt:
        return 'Tuna Melt';
      case SandwichType.meatballMarinara:
        return 'Meatball Marinara';
    }
  }

  String get image {
    String typeString = type.name;
    String sizeString = isFootlong ? 'footlong' : 'six_inch';
    // Return key without leading 'assets/' so web will request 'assets/images/...' (correct)
    return 'images/${typeString}_$sizeString.png';
  }
}
