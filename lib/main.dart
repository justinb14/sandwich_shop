import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/views/about_screen.dart';
import 'package:sandwich_shop/views/profile_screen.dart';
import 'package:sandwich_shop/views/app_drawer.dart';
import 'package:sandwich_shop/views/responsive_scaffold.dart';

// top-level scaffold & navigator keys (used for SnackBar/navigation elsewhere if needed)
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      navigatorKey: _navigatorKey,
      title: 'Sandwich Shop App',
      initialRoute: '/',
      routes: {
        '/': (context) => const OrderScreen(),
        '/about': (context) => const AboutScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}

// New OrderScreen + state implementing the requested UI and image display
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Cart _cart = Cart();
  final TextEditingController _notesController = TextEditingController();

  SandwichType _selectedSandwichType = SandwichType.veggieDelight;
  bool _isFootlong = true;
  bool _isToasted = false;
  BreadType _selectedBreadType = BreadType.white;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addToCart() {
    if (_quantity > 0) {
      final Sandwich sandwich = Sandwich(
        type: _selectedSandwichType,
        isFootlong: _isFootlong,
        breadType: _selectedBreadType,
        isToasted: _isToasted,
      );

      setState(() {
        _cart.add(sandwich, _quantity); // positional quantity
      });

      String sizeText = _isFootlong ? 'footlong' : 'six-inch';
      String confirmationMessage =
          'Added $_quantity $sizeText ${sandwich.name} sandwich(es) on ${_selectedBreadType.name} bread to cart';

      // show a SnackBar using the scaffold messenger key
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(confirmationMessage, key: const Key('confirmationMessage'))),
      );

      debugPrint(confirmationMessage);
    }
  }

  VoidCallback? _getAddToCartCallback() {
    if (_quantity > 0) {
      return _addToCart;
    }
    return null;
  }

  List<DropdownMenuEntry<SandwichType>> _buildSandwichTypeEntries() {
    List<DropdownMenuEntry<SandwichType>> entries = [];
    for (SandwichType type in SandwichType.values) {
      Sandwich sandwich =
          Sandwich(type: type, isFootlong: true, breadType: BreadType.white);
      DropdownMenuEntry<SandwichType> entry = DropdownMenuEntry<SandwichType>(
        value: type,
        label: sandwich.name,
      );
      entries.add(entry);
    }
    return entries;
  }

  List<DropdownMenuEntry<BreadType>> _buildBreadTypeEntries() {
    List<DropdownMenuEntry<BreadType>> entries = [];
    for (BreadType bread in BreadType.values) {
      DropdownMenuEntry<BreadType> entry = DropdownMenuEntry<BreadType>(
        value: bread,
        label: bread.name,
      );
      entries.add(entry);
    }
    return entries;
  }

  String _getCurrentImagePath() {
    final Sandwich sandwich = Sandwich(
      type: _selectedSandwichType,
      isFootlong: _isFootlong,
      breadType: _selectedBreadType,
      isToasted: false,
    );
    return sandwich.image;
  }

  void _onSandwichTypeChanged(SandwichType? value) {
    if (value != null) {
      setState(() {
        _selectedSandwichType = value;
      });
    }
  }

  void _onSizeChanged(bool value) {
    setState(() {
      _isFootlong = value;
    });
  }

  void _onBreadTypeChanged(BreadType? value) {
    if (value != null) {
      setState(() {
        _selectedBreadType = value;
      });
    }
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });
    }
  }

  VoidCallback? _getDecreaseCallback() {
    if (_quantity > 0) {
      return _decreaseQuantity;
    }
    return null;
  }

  void _viewCartPage() {
    _navigatorKey.currentState?.push(MaterialPageRoute<void>(
      builder: (context) => CartPage(cart: _cart),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 48,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            // logo stored at assets/images/logo.png per pubspec.yaml
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
          ),
        ),
        title: const Text(
          'Sandwich Counter',
          style: heading1,
        ),
        actions: [
          IconButton(
            key: const Key('viewCartAppBar'),
            icon: const Icon(Icons.shopping_cart),
            onPressed: _viewCartPage,
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 300,
                  child: Image.asset(
                    _getCurrentImagePath(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          'Image not found',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                DropdownMenu<SandwichType>(
                  width: double.infinity,
                  label: const Text('Sandwich Type'),
                  textStyle: const TextStyle(fontSize: 16),
                  initialSelection: _selectedSandwichType,
                  onSelected: _onSandwichTypeChanged,
                  dropdownMenuEntries: _buildSandwichTypeEntries(),
                ),
                const SizedBox(height: 20),
                // Size selector as segmented control (Six-inch / Footlong)
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Six-inch', label: Text('Six-inch')),
                    ButtonSegment(value: 'Footlong', label: Text('Footlong')),
                  ],
                  selected: {_isFootlong ? 'Footlong' : 'Six-inch'},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _isFootlong = newSelection.first == 'Footlong';
                    });
                  },
                ),
                const SizedBox(height: 12),
                // Toasted toggle (on/off switch)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('untoasted', style: TextStyle(fontSize: 16)),
                    Switch(
                      key: const Key('toastedSwitch'),
                      value: _isToasted,
                      onChanged: (value) => setState(() => _isToasted = value),
                    ),
                    const Text('toasted', style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),
                DropdownMenu<BreadType>(
                  width: double.infinity,
                  label: const Text('Bread Type'),
                  textStyle: const TextStyle(fontSize: 16),
                  initialSelection: _selectedBreadType,
                  onSelected: _onBreadTypeChanged,
                  dropdownMenuEntries: _buildBreadTypeEntries(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Quantity: ', style: TextStyle(fontSize: 16)),
                    IconButton(
                      key: const Key('qtyDecrease'),
                      onPressed: _getDecreaseCallback(),
                      icon: const Icon(Icons.remove),
                    ),
                    Text('$_quantity', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                      key: const Key('qtyIncrease'),
                      onPressed: _increaseQuantity,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                StyledButton(
                  onPressed: _getAddToCartCallback(),
                  icon: Icons.add_shopping_cart,
                  label: 'Add to Cart',
                  backgroundColor: Colors.green,
                  key: const Key('addToCart'),
                ),
                const SizedBox(height: 12),
                StyledButton(
                  onPressed: _viewCartPage,
                  icon: Icons.remove_red_eye,
                  label: 'View Cart',
                  backgroundColor: Colors.blue,
                  key: const Key('viewCart'),
                ),
                const SizedBox(height: 20),
                // Add link to profile screen at the bottom
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  child: const Text('Profile / Sign In'),
                ),
              ],
            ),
          ),
        ),
      ),
      currentRoute: '/',
    );
  }
}

// StyledButton supporting both older and newer parameter shapes
class StyledButton extends StatelessWidget {
  final String? text; // legacy
  final String? label; // new
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const StyledButton({
    this.text,
    this.label,
    this.icon,
    this.backgroundColor,
    required this.onPressed,
    this.isEnabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = label ?? text ?? '';
    final enabled = onPressed != null && isEnabled;
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? (backgroundColor ?? Colors.red) : Colors.grey,
        foregroundColor: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(displayText),
          ],
        ),
      ),
    );
  }
}

// CartPage uses Cart.getItems() and Cart.itemTotal(...) to display per-line totals
class CartPage extends StatelessWidget {
  final Cart cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final totalItems = cart.totalItems();
    final totalPrice = cart.totalPrice();
    final items = cart.getItems();

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
            if (items.isNotEmpty)
              Expanded(
                child: ListView(
                  children: items.entries.map((entry) {
                    final sandwich = entry.key;
                    final count = entry.value;
                    final sizeLabel = sandwich.isFootlong ? 'Footlong' : 'Six-inch';
                    final toastState = sandwich.isToasted ? 'toasted' : 'untoasted';
                    final price = cart.itemTotal(sandwich);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${sandwich.name} ($sizeLabel, $toastState) x $count'),
                          Text('£${price.toStringAsFixed(2)}'),
                        ],
                      ),
                    );
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
