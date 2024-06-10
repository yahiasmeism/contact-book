import 'package:flutter/material.dart';

class MyRouteObserver extends NavigatorObserver {
  List<Route<dynamic>> routeStack = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    routeStack.add(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    routeStack.remove(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      final int index = routeStack.indexOf(oldRoute);
      if (index != -1) {
        routeStack[index] = newRoute!;
      }
    }
  }

  bool isRoutePresent(String routeName) {
    return routeStack.any((route) => route.settings.name == routeName);
  }
}
