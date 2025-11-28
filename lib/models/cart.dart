import '../models/sandwich.dart';
import '../repositories/pricing_repository.dart';

class Cart {
  // internal maps keyed by a stable string derived from Sandwich properties
  final Map<String, int> _items = {};
  final Map<String, Sandwich> _lookup = {};

  String _keyFor(Sandwich s) =>
      '${s.type.name}_${s.isFootlong ? 'footlong' : 'six_inch'}_${s.breadType.name}_${s.isToasted ? 'toasted' : 'untoasted'}';

  void add(Sandwich sandwich, [int quantity = 1]) {
    if (quantity <= 0) return;
    final key = _keyFor(sandwich);
    _items[key] = (_items[key] ?? 0) + quantity;
    _lookup[key] = sandwich;
  }

  void remove(Sandwich sandwich, [int quantity = 1]) {
    if (quantity <= 0) return;
    final key = _keyFor(sandwich);
    final current = _items[key];
    if (current == null) return;
    final remaining = current - quantity;
    if (remaining > 0) {
      _items[key] = remaining;
    } else {
      _items.remove(key);
      _lookup.remove(key);
    }
  }

  void clear() {
    _items.clear();
    _lookup.clear();
  }

  // Number of items (sum of quantities)
  int totalItems() => _items.values.fold<int>(0, (a, b) => a + b);

  // Returns a map of Sandwich -> quantity for inspection
  Map<Sandwich, int> getItems() {
    final result = <Sandwich, int>{};
    _items.forEach((k, v) {
      final sandwich = _lookup[k];
      if (sandwich != null) result[sandwich] = v;
    });
    return result;
  }

  // compute total price using PricingRepository internally
  double totalPrice() {
    final repo = PricingRepository();
    double sum = 0.0;
    _items.forEach((k, qty) {
      final sandwich = _lookup[k];
      if (sandwich == null) return;
      final sizeLabel = sandwich.isFootlong ? 'Footlong' : 'Six-inch';
      sum += repo.calculateTotalPrice(sizeLabel, qty);
    });
    return sum;
  }

  // New: return total price for a specific Sandwich entry (for display in UI)
  double itemTotal(Sandwich sandwich) {
    final key = _keyFor(sandwich);
    final qty = _items[key] ?? 0;
    if (qty == 0) return 0.0;
    final repo = PricingRepository();
    final sizeLabel = sandwich.isFootlong ? 'Footlong' : 'Six-inch';
    return repo.calculateTotalPrice(sizeLabel, qty);
  }

  bool get isEmpty => _items.isEmpty;
}
