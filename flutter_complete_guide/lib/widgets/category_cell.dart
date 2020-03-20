import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/extension.dart';

class CategoryCell extends StatelessWidget {
  final Category categoryItem;

  const CategoryCell({@required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.theme.primaryColor,
      borderRadius: BorderRadius.circular(6),
      onTap: () => context.navigator.pushNamed(
        '/category-detail',
        arguments: categoryItem,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(colors: [
            categoryItem.color.withPercentAlpha(0.6),
            categoryItem.color.withPercentAlpha(0.7),
            categoryItem.color.withPercentAlpha(0.8),
            categoryItem.color.withPercentAlpha(0.9),
            categoryItem.color.withPercentAlpha(1.0),
          ]),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          alignment: AlignmentDirectional.bottomStart,
          child: Text(
            categoryItem.title,
            style: context.theme.textTheme.title,
          ),
        ),
      ),
    );
  }
}
