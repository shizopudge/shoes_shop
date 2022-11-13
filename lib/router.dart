import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shoes_app_ui_training/auth/screens/login_screen.dart';
import 'package:shoes_app_ui_training/screens/portal.dart';
import 'package:shoes_app_ui_training/screens/purchases_history.dart';
import 'package:shoes_app_ui_training/screens/shoe_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});
final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: Portal()),
  '/purchases-history': (_) =>
      const MaterialPage(child: PurchasesHistoryScreen()),
  '/shoe-screen/:shoeId': (route) => MaterialPage(
        child: ShoeScreen(
          shoeId: route.pathParameters['shoeId']!,
        ),
      ),
  // '/edit-cart-screen/:cartId': (route) => MaterialPage(
  //       child: CartEditScreen(
  //         shoeId: route.pathParameters['cartId']!,
  //       ),
  //     ),
});
