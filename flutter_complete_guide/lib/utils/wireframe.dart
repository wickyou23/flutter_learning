import 'package:flutter/widgets.dart';
import '../screens/filter_screen.dart';
import '../screens/tabbar_screen.dart';
import '../screens/meal_detail_screen.dart';
import '../screens/category_detail_screen.dart';
// import '../screens/category_page.dart';

class AppWireFrame {
  static final Map<String, WidgetBuilder> routes = {
    '/': (ctx) => TabbarScreen(),
    '/category-detail': (ctx) => CategoryDetailScreen(),
    '/meal-detail': (ctx) => MealDetailScreen(),
    '/filter': (ctx) => FilterScreen()
  };
}
