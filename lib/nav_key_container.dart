import 'package:flutter/widgets.dart';

class NavKey {
  static final navKey = GlobalKey<NavigatorState>();
  static String? currentRouterName = ModalRoute.of(navKey.currentContext!)?.settings.name;
}