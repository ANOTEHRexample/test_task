
import 'package:flutter/material.dart';

class CharactersData extends InheritedWidget {
  final Map<String, int>? indexContainer;
  const CharactersData({
    super.key,
    this.indexContainer,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant CharactersData oldWidget) {
    return indexContainer != oldWidget.indexContainer;
  }

  static CharactersData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CharactersData>() as CharactersData;
}