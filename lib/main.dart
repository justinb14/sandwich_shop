import 'package:flutter/material.dart';

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

  void _addQuantity() {
    if (quantity < maxQuantity) {
      setState(() {
        quantity++;
      });
    }
  }

  void _removeQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
