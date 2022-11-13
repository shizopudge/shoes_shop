import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app_ui_training/screens/cart_screen.dart';
import 'package:shoes_app_ui_training/screens/favorite_screen.dart';
import 'package:shoes_app_ui_training/screens/home_screen.dart';

class Portal extends ConsumerStatefulWidget {
  const Portal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortalState();
}

class _PortalState extends ConsumerState<Portal> {
  int _page = 0;

  static const tabWidgets = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
  ];
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabWidgets[_page],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Cart',
          ),
        ],
        onTap: onPageChanged,
        currentIndex: _page,
      ),
    );
  }
}
