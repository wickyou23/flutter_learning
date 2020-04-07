import 'package:flutter/widgets.dart';
import 'package:flutter_complete_guide/screens/shop_screen.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    '/': (ctx) => ShopScreen(),
  };
}
