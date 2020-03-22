import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/app_case.dart';

import '../dummy_data.dart';
import '../widgets/meal_cell.dart';

class FavoriteScreen extends StatelessWidget {
  final _mealItems = DUMMY_MEALS
      .where((item) => AppCache().favouriteIds.contains(item.id))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _mealItems.length,
        itemBuilder: (ctx, index) {
          return MealCell(mealItem: _mealItems[index]);
        },
      ),
    );
  }
}
