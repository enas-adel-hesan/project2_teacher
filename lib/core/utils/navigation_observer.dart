import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print("📍 Pushed: ${route.settings.name}");
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print("⬅️ Popped: ${route.settings.name}");
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print("❌ Removed: ${route.settings.name}");
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (kDebugMode) {
      print("🔁 Replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}");
    }
  }
}
