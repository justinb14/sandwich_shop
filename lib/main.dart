import 'package:flutter/material.dart';
import 'repositories/pricing_repository.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

// Add top-level keys so SnackBars and navigation can be used from AppState
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const App());
}

// Main App
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final int maxQuantity = 10;
  String selectedSandwichType = 'Footlong';
  bool _isToasted = false;
  final PricingRepository pricingRepository = PricingRepository();

  // cart map now tracks per-type and per-toast state counts
  // structure: { "Footlong": { "toasted": 2, "untoasted": 1 }, "Six-inch": {...} }
  final Map<String, Map<String, int>> _cart = {};

  // helper getters
  int _cartItemsCount() => _cart.values.fold(0, (a, m) => a + (m.values.fold(0, (x, y) => x + y)));
  double _cartTotal() => _cart.entries.fold<double>(0.0, (double sum, MapEntry<String, Map<String, int>> e) {
        final type = e.key;
        final innerTotal = e.value.entries.fold<double>(0.0, (double s, MapEntry<String, int> inner) {
          final cnt = inner.value;
          return s + pricingRepository.calculateTotalPrice(type, cnt);
        });
        return sum + innerTotal;
      });

  void _addToCart() {
    // Add exactly one of the currently selected sandwich (no quantity selector)
    final added = 1;
    setState(() {
      final toastKey = _isToasted ? 'toasted' : 'untoasted';
      final inner = _cart[selectedSandwichType] ?? <String, int>{};
      inner[toastKey] = (inner[toastKey] ?? 0) + added;
      _cart[selectedSandwichType] = inner;
    });
    final message = 'Added $added $selectedSandwichType sandwich (${_isToasted ? "toasted" : "untoasted"}) to cart.';
    _showConfirmation(message);
  }

  void _removeOneFromCartPreferringSelectedType() {
    if (_cartItemsCount() == 0) return;
    setState(() {
      final type = selectedSandwichType;
      final toastKey = _isToasted ? 'toasted' : 'untoasted';
      // try removing from selected type+toast first
      if ((_cart[type]?[toastKey] ?? 0) > 0) {
        _cart[type]![toastKey] = _cart[type]![toastKey]! - 1;
        if (_cart[type]![toastKey] == 0) _cart[type]!.remove(toastKey);
        if (_cart[type]!.isEmpty) _cart.remove(type);
        return;
      }
      // otherwise remove from any available entry
      final outerKey = _cart.keys.first;
      final innerKey = _cart[outerKey]!.keys.first;
      _cart[outerKey]![innerKey] = _cart[outerKey]![innerKey]! - 1;
      if (_cart[outerKey]![innerKey] == 0) _cart[outerKey]!.remove(innerKey);
      if (_cart[outerKey]!.isEmpty) _cart.remove(outerKey);
    });
  }

  // Update to use the top-level ScaffoldMessenger key
  void _showConfirmation(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message, key: const Key('confirmationMessage')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // navigate to the CartPage route using navigator key (context above MaterialApp)
  void _viewCartPage() {
    _navigatorKey.currentState?.push(MaterialPageRoute<void>(
      builder: (context) => CartPage(
        cart: _cart,
        pricingRepository: pricingRepository,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // attach the scaffoldMessengerKey and navigatorKey so they can be used from AppState
      scaffoldMessengerKey: _scaffoldMessengerKey,
      navigatorKey: _navigatorKey,
      title: 'Sandwich Shop App',
      home: Scaffold(
        appBar: AppBar(
          leading: SizedBox(
            width: 48,
            height: 48,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
          ),
          title: const Text('Sandwich Counter'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // removed ambiguous selectedQuantity display
              // ...existing code...
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Footlong', label: Text('Footlong')),
                  ButtonSegment(value: 'Six-inch', label: Text('Six-inch')),
                ],
                selected: {selectedSandwichType},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    selectedSandwichType = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('untoasted', style: TextStyle(fontSize: 16)),
                  Switch(
                    key: const Key('toastedSwitch'),
                    value: _isToasted,
                    onChanged: (value) {
                      setState(() => _isToasted = value);
                    },
                  ),
                  const Text('toasted', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              // Permanent cart summary (aggregated)
              Text(
                'Cart: ${_cartItemsCount()} items - Total: £${_cartTotal().toStringAsFixed(2)}',
                key: const Key('cartSummary'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),
              // action buttons: Add to Cart and View Cart
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledButton(
                    key: const Key('addToCart'),
                    text: 'Add to Cart',
                    isEnabled: true,
                    onPressed: _addToCart,
                  ),
                  const SizedBox(width: 12),
                  StyledButton(
                    key: const Key('viewCart'),
                    text: 'View Cart',
                    isEnabled: true,
                    onPressed: _viewCartPage,
                  ),
                  const SizedBox(width: 12),
                  // small convenience: remove single item from cart (prefers selected type)
                  StyledButton(
                    key: const Key('removeFromCart'),
                    text: 'Remove one',
                    isEnabled: _cartItemsCount() > 0,
                    onPressed: _removeOneFromCartPreferringSelectedType,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  const StyledButton({
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? Colors.red : Colors.grey,
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }
}

// New CartPage: shows cart breakdown including toasted/untoasted and totals
class CartPage extends StatelessWidget {
  final Map<String, Map<String, int>> cart;
  final PricingRepository pricingRepository;

  const CartPage({super.key, required this.cart, required this.pricingRepository});

  @override
  Widget build(BuildContext context) {
    final totalItems = cart.values.fold<int>(0, (a, m) => a + m.values.fold(0, (x, y) => x + y));
    final totalPrice = cart.entries.fold<double>(0.0, (double sum, MapEntry<String, Map<String, int>> e) {
      final type = e.key;
      final inner = e.value.entries.fold<double>(0.0, (double s, MapEntry<String, int> inner) {
        return s + pricingRepository.calculateTotalPrice(type, inner.value);
      });
      return sum + inner;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total items: $totalItems', key: const Key('cartPageItems'), style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            if (cart.isEmpty) const Text('Cart is empty', key: Key('cartPageEmpty')),
            if (cart.isNotEmpty)
              Expanded(
                child: ListView(
                  children: cart.entries.expand((entry) {
                    final type = entry.key;
                    return entry.value.entries.map((inner) {
                      final toastState = inner.key; // "toasted" or "untoasted"
                      final count = inner.value;
                      final price = pricingRepository.calculateTotalPrice(type, count);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$type (${toastState}) x $count'),
                            Text('£${price.toStringAsFixed(2)}'),
                          ],
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
            const SizedBox(height: 12),
            Text('Total: £${totalPrice.toStringAsFixed(2)}', key: const Key('cartPageTotal'), style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
