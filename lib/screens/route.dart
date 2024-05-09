import 'package:flutter/material.dart';
import 'package:nt_exam_4/screens/cart/cart_screen.dart';
import 'package:nt_exam_4/screens/detail/detail_screen.dart';
import 'package:nt_exam_4/screens/home/home_screen.dart';
import 'package:nt_exam_4/screens/itemlist/item_list_screen.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.cartScreen:
        return navigate(const CartScreen());
      case RouteNames.homeScreen:
        return navigate(const HomeScreen());
      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text("This kind of rout does not exist!"),
            ),
          ),
        );
    }
  }

  static navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

class RouteNames {
  static const String homeScreen = "/home_route";
  static const String itemListScreen = "/item_route";
  static const String cartScreen = "/cart_route";
}