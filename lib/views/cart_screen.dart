import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/cart_item.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';
import 'package:sandwich_shop/widgets/styled_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  Future<void> _navigateToCheckout(BuildContext context, Cart cart) async {
    if (cart.isEmpty) {
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
        builder: (context) => CheckoutScreen(cart: cart),
      ),
    );

    if (result != null && context.mounted) {
      cart.clear();

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
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Your Cart'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (cart.isEmpty)
                  const Text('Cart is empty')
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final CartItem item = cart.items[index];
                        final sandwich = item.sandwich;
                        final sizeLabel = sandwich.isFootlong ? 'Footlong' : 'Six-inch';
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ListTile(
                            title: Text('${sandwich.name} ($sizeLabel, ${sandwich.breadType.name})'),
                            subtitle: Text('Subtotal: £${item.itemSubtotal.toStringAsFixed(2)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: item.quantity > 1
                                      ? () => cart.updateItemQuantity(sandwich, item.quantity - 1)
                                      : null,
                                ),
                                Text('${item.quantity}', style: const TextStyle(fontSize: 16)),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () => cart.updateItemQuantity(sandwich, item.quantity + 1),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => cart.removeItem(sandwich),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total: £${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Builder(
                  builder: (BuildContext context) {
                    final bool cartHasItems = !cart.isEmpty;
                    if (cartHasItems) {
                      return StyledButton(
                        onPressed: () => _navigateToCheckout(context, cart),
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
          ),
        );
      },
    );
  }
}