import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_drawer.dart';

class ResponsiveScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final String? currentRoute;
  final FloatingActionButton? floatingActionButton;

  const ResponsiveScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.currentRoute,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;
    if (isWide) {
      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _routeToIndex(currentRoute),
              onDestinationSelected: (idx) {
                switch (idx) {
                  case 0:
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
                    break;
                  case 1:
                    Navigator.of(context).pushNamed('/cart');
                    break;
                  case 2:
                    Navigator.of(context).pushNamed('/profile');
                    break;
                  case 3:
                    Navigator.of(context).pushNamed('/about');
                    break;
                }
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.fastfood),
                  label: Text('Order'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Cart'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.info),
                  label: Text('About'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
        floatingActionButton: floatingActionButton,
      );
    } else {
      return Scaffold(
        appBar: appBar,
        drawer: AppDrawer(currentRoute: currentRoute),
        body: body,
        floatingActionButton: floatingActionButton,
      );
    }
  }

  int _routeToIndex(String? route) {
    switch (route) {
      case '/':
        return 0;
      case '/cart':
        return 1;
      case '/profile':
        return 2;
      case '/about':
        return 3;
      default:
        return 0;
    }
  }
}
