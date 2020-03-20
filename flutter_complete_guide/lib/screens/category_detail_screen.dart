import 'package:flutter/material.dart';
import '../widgets/meal_cell.dart';
import '../dummy_data.dart';
import '../utils/extension.dart';
import '../models/category.dart';

class CategoryDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catogeryItem = context.route.settings.arguments as Category;
    final mealItems = DUMMY_MEALS
        .where((item) => item.categories.contains(catogeryItem.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(catogeryItem.title),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: mealItems.length,
          itemBuilder: (ctx, index) {
            return MealCell(mealItem: mealItems[index]);
          },
        ),
      ),
    );
  }
}
