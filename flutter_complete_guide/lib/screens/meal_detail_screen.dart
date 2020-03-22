import 'package:flutter/material.dart';
import '../widgets/dynamic_flexible_space_bar_title.dart';
import '../models/meal.dart';
import '../utils/extension.dart';

class MealDetailScreen extends StatefulWidget {
  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  
  Meal _meal;

  @override
  Widget build(BuildContext context) {
    _meal = context.routeArg as Meal;
    final double _expandedHeight = context.media.size.height * 0.33;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _sliverAppBar(_expandedHeight),
          _headerWidget('Ingredients'),
          _ingredientsWidget(),
          _headerWidget('Steps'),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8.0),
          ),
          _stepsWidget(),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar(double expandedHeight) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: false,
      expandedHeight: expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        title: DynamicFlexibleSpaceBarTitle(
          title: _meal.title,
        ),
        background: Image.network(
          _meal.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  SliverToBoxAdapter _headerWidget(String title) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            alignment: AlignmentDirectional.centerStart,
            height: 50,
            child: Text(
              title,
              style: context.theme.textTheme.title.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const Divider(
            height: 2,
            indent: 16,
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _ingredientsWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        height: (_meal.ingredients.length * 35 + 16).toDouble(),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.withPercentAlpha(0.8),
              Colors.blueAccent.withPercentAlpha(0.9),
              Colors.blueAccent.withPercentAlpha(1.0),
            ],
          ),
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, index) {
            return Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: AlignmentDirectional.centerStart,
              height: 35,
              child: Text(
                _meal.ingredients[index],
                style: context.theme.textTheme.title.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            );
          },
          itemCount: _meal.ingredients.length,
        ),
      ),
    );
  }

  SliverList _stepsWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontFamily: 'NunitoSans',
                  ),
                ),
              ),
              title: Text(
                _meal.steps[index],
                style: const TextStyle(
                  fontFamily: 'NunitoSans',
                ),
              ),
            ),
          );
        },
        childCount: _meal.steps.length,
      ),
    );
  }
}
