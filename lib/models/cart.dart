import 'package:flutter/foundation.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart_item.dart';

class Cart extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.itemSubtotal);

  int get totalItems =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  void add(Sandwich sandwich, int quantity) {
    final index = _items.indexWhere((item) => item.sandwich == sandwich);
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
    notifyListeners();
  }

  void updateItemQuantity(Sandwich sandwich, int newQuantity) {
    final index = _items.indexWhere((item) => item.sandwich == sandwich);
    if (index != -1) {
      if (newQuantity > 0) {
        _items[index].quantity = newQuantity;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(Sandwich sandwich) {
    _items.removeWhere((item) => item.sandwich == sandwich);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool get isEmpty => _items.isEmpty;
}
