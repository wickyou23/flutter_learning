import 'package:flutter/material.dart';

import '../models/app_case.dart';
import 'left_menu_screen.dart';
import '../utils/extension.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget _switchTitleLayout(
      {bool value,
      String title,
      String subtitle,
      ValueChanged<bool> onChanged}) {
    return SwitchListTile(
      value: value,
      title: Text(
        title,
        style: context.theme.textTheme.title.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: context.theme.textTheme.title.copyWith(
          fontSize: 14,
        ),
      ),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Meal'),
      ),
      drawer: LeftMenuScreen(),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            _switchTitleLayout(
                value: AppCache().isGlutenFree,
                title: 'Gluten',
                subtitle: 'Meals include Gluten-Free',
                onChanged: (isEnable) {
                  setState(() {
                    AppCache().isGlutenFree = isEnable;
                  });
                }),
            _switchTitleLayout(
              value: AppCache().isVegan,
              title: 'Vegan',
              subtitle: 'Meals include Vegan',
              onChanged: (isEnable) {
                setState(() {
                  AppCache().isVegan = isEnable;
                });
              },
            ),
            _switchTitleLayout(
              value: AppCache().isVegetarian,
              title: 'Vegetarian',
              subtitle: 'Meals include Vegetarian',
              onChanged: (isEnable) {
                setState(() {
                  AppCache().isVegetarian = isEnable;
                });
              },
            ),
            _switchTitleLayout(
              value: AppCache().isLactoseFree,
              title: 'Lactose',
              subtitle: 'Meals include Lactose-Free',
              onChanged: (isEnable) {
                setState(() {
                  AppCache().isLactoseFree = isEnable;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
