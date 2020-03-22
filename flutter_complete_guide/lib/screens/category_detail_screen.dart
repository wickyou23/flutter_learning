import 'package:flutter/material.dart';
import '../models/app_case.dart';
import '../models/meal.dart';
import '../widgets/meal_cell.dart';
import '../dummy_data.dart';
import '../utils/extension.dart';
import '../models/category.dart';

class CategoryDetailScreen extends StatefulWidget {
  @override
  _CategoryDetailScreenState createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<Meal> _mealItems = [];
  Category _catogeryItem;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      _catogeryItem = context.route.settings.arguments as Category;
      _mealItems = DUMMY_MEALS.where((item) {
        final appCache = AppCache();
        final isContains = item.categories.contains(_catogeryItem.id);
        if ((appCache.isGlutenFree & item.isGlutenFree & isContains) == true) {
          return true;
        }

        if ((appCache.isLactoseFree & item.isLactoseFree & isContains) ==
            true) {
          return true;
        }

        if ((appCache.isVegan & item.isVegan & isContains) == true) {
          return true;
        }

        if ((appCache.isVegetarian & item.isVegetarian & isContains) == true) {
          return true;
        }

        final isAllFalse = !appCache.isGlutenFree &
            !item.isGlutenFree &
            !appCache.isLactoseFree &
            !item.isLactoseFree &
            !appCache.isVegan &
            !item.isVegan &
            !appCache.isVegetarian &
            !item.isVegetarian;
        return isAllFalse & isContains;
      }).toList();
      _isLoaded = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_catogeryItem.title),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: _mealItems.length,
          itemBuilder: (ctx, index) {
            return MealCell(mealItem: _mealItems[index]);
          },
        ),
      ),
    );
  }
}
