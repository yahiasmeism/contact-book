// import 'dart:developer';

// import 'package:flutter/material.dart';

// class MyRouteObserver extends NavigatorObserver {
//   List<Route<dynamic>> routeStack = [];

//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     routeStack.add(route);
//     log('Push  ${previousRoute?.settings.name} => ${route.settings.name}');
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     routeStack.remove(route);
//     log('Pop  ${route.settings.name} => ${previousRoute?.settings.name}');
//   }

//   @override
//   void didRemove(Route route, Route? previousRoute) {
//     super.didRemove(route, previousRoute);
//     routeStack.remove(route);
//     log('Remove ${previousRoute?.settings.name} => ${route.settings.name}');
//   }

//   @override
//   void didReplace({Route? newRoute, Route? oldRoute}) {
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//     if (oldRoute != null) {
//       final int index = routeStack.indexOf(oldRoute);
//       if (index != -1) {
//         routeStack[index] = newRoute!;
//       }
//     }
//     log('Replace ${oldRoute!.settings.name} => ${newRoute!.settings.name}');
//   }

//   bool isRoutePresent(String routeName) {
//     return routeStack.any((route) => route.settings.name == routeName);
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';

List<Route?> routeStack = [];

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    routeStack.add(route);
    log('didPush: ${previousRoute?.settings.name} => ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    routeStack.remove(route);
    log('didPop: ${route.settings.name} => ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
    log('didPush: ${previousRoute?.settings.name} => ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final index = routeStack.indexOf(oldRoute);
    routeStack[index] = newRoute;
    log('didPush: ${oldRoute?.settings.name} => ${newRoute?.settings.name}');
  }

  bool isRoutePresent(String routeName) {
    return routeStack.any((route) => route!.settings.name == routeName);
  }
}
