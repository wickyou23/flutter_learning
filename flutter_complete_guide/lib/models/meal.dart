import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

extension ComplexityExt on Complexity {
  String get title {
    switch (this) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return '';
    }
  }
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

extension AffordabilityExt on Affordability {
  String get title {
    switch (this) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return '';
    }
  }
}

class Meal {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final List<String> categories;
  final List<String> ingredients;
  final List<String> steps;
  final Complexity complexity;
  final Affordability affordability;

  const Meal({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.isGlutenFree,
    @required this.isLactoseFree,
    @required this.isVegan,
    @required this.isVegetarian,
    @required this.categories,
    @required this.ingredients,
    @required this.steps,
    @required this.complexity,
    @required this.affordability,
  });
}
