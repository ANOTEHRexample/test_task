import 'package:flutter/material.dart';

abstract class AppRouter {
  pushNamed(
      {required String name,
      Object? arguments,
      bool asRoot,
      BuildContext? buildContext});
  popAndPushNamed(
      {required String name,
      Object? arguments,
      bool asRoot,
      BuildContext? buildContext});
  pushReplacementNamed(
      {required String name,
      Object? arguments,
      bool asRoot,
      BuildContext? buildContext});
  pushNamedAndRemoveUntil(
      {required String name,
      Object? arguments,
      bool asRoot,
      BuildContext? buildContext});
  pop({Object? result, BuildContext? buildContext});
}
