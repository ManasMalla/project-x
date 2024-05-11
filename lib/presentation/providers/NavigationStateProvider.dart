import 'package:flutter/material.dart';

enum NavigationDestinations { home, search, create, bussiness, profile }

class NavigationStateProvider extends ChangeNotifier {
  NavigationDestinations _currentDestination = NavigationDestinations.home;

  int get currentDestination =>
      NavigationDestinations.values.indexOf(_currentDestination);

  void navigateTo(NavigationDestinations destination) {
    _currentDestination = destination;
    notifyListeners();
  }
}
