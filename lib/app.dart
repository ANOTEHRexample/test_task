import 'package:flutter/services.dart';
import 'package:test_task_app/nav_key_container.dart';
import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:flutter/material.dart';
import 'routers/routes.dart';
import 'routers/screen_names.dart';

class MyApp extends StatelessWidget {

 const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    return ConnectivityAppWrapper(
      app: MaterialApp(
        title: 'test_task',
        navigatorKey: NavKey.navKey,
        initialRoute: ScreenNames.home,
        onGenerateRoute: (RouteSettings setting) =>
            Routers.generateRoute(setting),
      ),
    );
  }
}
