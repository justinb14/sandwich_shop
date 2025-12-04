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
    // map enum -> snake_case base filename to match assets (e.g. veggie_delight)
    const typeMap = {
      SandwichType.veggieDelight: 'veggie_delight',
      SandwichType.chickenTeriyaki: 'chicken_teriyaki',
      SandwichType.tunaMelt: 'tuna_melt',
      SandwichType.meatballMarinara: 'meatball_marinara',
    };
    final typeString = typeMap[type]!;
    final sizeString = isFootlong ? 'footlong' : 'six_inch';
    // return the full asset key pointing at the file under assets/images/
    return 'assets/images/${typeString}_$sizeString.png';
  }
}
