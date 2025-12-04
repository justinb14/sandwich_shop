import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/widgets/styled_button.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> _navigateToCheckout() async {
    if (widget.cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(cart: widget.cart),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        widget.cart.clear();
      });

      final String orderId = result['orderId'] as String;
      final String estimatedTime = result['estimatedTime'] as String;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Order $orderId confirmed! Estimated time: $estimatedTime'),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          // Cart items and other UI components
          const SizedBox(height: 20),
          Builder(
            builder: (BuildContext context) {
              final bool cartHasItems = widget.cart.items.isNotEmpty;
              if (cartHasItems) {
                return StyledButton(
                  onPressed: _navigateToCheckout,
                  icon: Icons.payment,
                  label: 'Checkout',
                  backgroundColor: Colors.orange,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 20),
          // Back to Order button
          StyledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icons.arrow_back,
            label: 'Back to Order',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}