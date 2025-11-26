import 'package:flutter/material.dart';
import 'repositories/pricing_repository.dart';

// Add a top-level ScaffoldMessenger key so SnackBars can be shown from AppState
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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
  int quantity = 5;
  final int maxQuantity = 10;
  String selectedSandwichType = 'Footlong';
  bool _isToasted = false; // New state variable
  final PricingRepository pricingRepository = PricingRepository();

  // New cart state
  int cartItems = 0;
  double cartTotal = 0.0;

  void _addQuantity() {
    if (quantity < maxQuantity) {
      // update quantity and cart in one setState so UI updates together
      setState(() {
        quantity++;
        cartItems++;
        // add the unit price for the current sandwich type
        cartTotal += pricingRepository.calculateTotalPrice(selectedSandwichType, 1);
      });
      // show a transient confirmation message in the UI
      final message = 'Added 1 $selectedSandwichType sandwich. Quantity: $quantity';
      _showConfirmation(message);
    }
  }

  void _removeQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // attach the scaffoldMessengerKey so SnackBars can be shown from AppState
      scaffoldMessengerKey: _scaffoldMessengerKey,
      title: 'Sandwich Shop App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Sandwich Counter')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$quantity $selectedSandwichType sandwich(es)',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
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
                    key: const Key('toastedSwitch'), // Unique key for the toasted switch
                    value: _isToasted,
                    onChanged: (value) {
                      setState(() => _isToasted = value);
                    },
                  ),
                  const Text('toasted', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Total Price: £${pricingRepository.calculateTotalPrice(selectedSandwichType, quantity).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),
              // Permanent cart summary (updates when items are added)
              Text(
                'Cart: $cartItems items - Total: £${cartTotal.toStringAsFixed(2)}',
                key: const Key('cartSummary'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledButton(
                    text: '+ Add',
                    isEnabled: quantity < maxQuantity,
                    onPressed: _addQuantity,
                  ),
                  const SizedBox(width: 16),
                  StyledButton(
                    text: '- Remove',
                    isEnabled: quantity > 0,
                    onPressed: _removeQuantity,
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
