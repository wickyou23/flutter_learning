import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _singleton = NavigationService._internal();

  NavigationService._internal();

  factory NavigationService() {
    return _singleton;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateAndReplaceTo(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }
}