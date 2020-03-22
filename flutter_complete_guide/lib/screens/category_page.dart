import 'package:flutter/material.dart';

import '../widgets/category_cell.dart';
import '../utils/extension.dart';
import '../dummy_data.dart';
import 'left_menu_screen.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categorys = DUMMY_CATEGORIES;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: context.media.size.width / 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3 / 2,
          ),
          itemCount: categorys.length,
          itemBuilder: (context, index) {
            return CategoryCell(
              categoryItem: categorys[index],
            );
          }),
    );
  }
}
