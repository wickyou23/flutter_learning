class AppCache {
  static final AppCache _singleton = AppCache._internal();

  bool showAll = false;
  bool isGlutenFree = true;
  bool isVegan = true;
  bool isVegetarian = true;
  bool isLactoseFree = true;
  List<String> favouriteIds = [];

  factory AppCache() {
    return _singleton;
  }

  AppCache._internal();
}