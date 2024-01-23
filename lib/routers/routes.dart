import 'package:test_task_app/injection_container.dart';
import 'package:test_task_app/screens/home/fragments/home/home_vm.dart';
import 'package:test_task_app/screens/home/fragments/bottom_tab_bar_page.dart';
import 'package:test_task_app/screens/item/item_page.dart';
import 'package:test_task_app/screens/item/item_vm.dart';
import 'package:flutter/material.dart';
import 'screen_names.dart';
import 'package:provider/provider.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case ScreenNames.item:
        builder = (BuildContext buildContext) {
          return ChangeNotifierProvider(
            create: (context) =>
                serviceLocator.get<ItemVM>(param1: settings.arguments),
            child: const ItemPage(),
          );
        };
        break;
      default:
        builder = (BuildContext buildContext) {
          return ChangeNotifierProvider(
            create: (context) =>
                serviceLocator.get<HomeVM>(param1: settings.arguments ?? 0),
            child: const BottomTabBarPage(),
          );
        };
        break;
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
