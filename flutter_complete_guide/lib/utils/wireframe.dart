import 'package:flutter/widgets.dart';
import '../screens/category_detail_screen.dart';
import '../screens/category_page.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    '/': (ctx) => CategoryPage(),
    '/category-detail': (ctx) => CategoryDetailScreen(),
  };
}
