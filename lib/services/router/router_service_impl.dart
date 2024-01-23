import 'package:test_task_app/nav_key_container.dart';
import 'package:test_task_app/services/router/router_service.dart';
import 'package:flutter/material.dart';

class AppRouterImpl implements AppRouter {
  @override
  pushNamed(
      {required String name,
      Object? arguments,
      bool asRoot = false,
      BuildContext? buildContext}) {
    return _getNavigator(asRoot: asRoot, buildContext: buildContext)
        ?.pushNamed(name, arguments: arguments);
  }

  @override
  popAndPushNamed(
      {required String name,
      Object? arguments,
      bool asRoot = false,
      BuildContext? buildContext}) {
    _getNavigator(asRoot: asRoot, buildContext: buildContext)
        ?.popAndPushNamed(name, arguments: arguments);
  }

  @override
  pushReplacementNamed(
      {required String name,
      Object? arguments,
      bool asRoot = false,
      BuildContext? buildContext}) {
    _getNavigator(asRoot: asRoot, buildContext: buildContext)
        ?.pushReplacementNamed(name, arguments: arguments);
  }

  @override
  pushNamedAndRemoveUntil(
      {required String name,
      Object? arguments,
      bool asRoot = false,
      BuildContext? buildContext}) {
    _getNavigator(asRoot: asRoot, buildContext: buildContext)
        ?.pushNamedAndRemoveUntil(
      name,
      ModalRoute.withName('/'),
      arguments: arguments,
    );
  }

  @override
  pop({Object? result, BuildContext? buildContext}) {
    _getNavigator(buildContext: buildContext)?.pop(result);
  }

  NavigatorState? _getNavigator(
      {bool asRoot = false, BuildContext? buildContext}) {
    final BuildContext? context = buildContext ?? NavKey.navKey.currentContext;
    if (context != null) {
      return Navigator.of(context, rootNavigator: asRoot);
    }
    return null;
  }
}
