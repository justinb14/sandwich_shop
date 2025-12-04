import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String? currentRoute;
  const AppDrawer({super.key, this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Sandwich Shop', style: TextStyle(fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.fastfood),
            title: const Text('Order'),
            selected: currentRoute == '/',
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
        ],
      ),
    );
  }
}
