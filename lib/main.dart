import 'package:flutter/material.dart';
import 'app.dart';
import 'injection_container.dart' as dependency_injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dependency_injector.init();

  runApp(
    const MyApp(),
  );
}
