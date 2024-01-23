import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task_app/data/models/character_model.dart';
import 'package:test_task_app/data/view/api/view_api.dart';
import 'package:test_task_app/data/view/repository/view_repository.dart';
import 'package:test_task_app/data/view/repository/view_repository_impl.dart';
import 'package:test_task_app/screens/home/fragments/home/home_vm.dart';
import 'package:test_task_app/screens/home/fragments/list/list_vm.dart';
import 'package:test_task_app/screens/item/item_vm.dart';
import 'package:test_task_app/services/router/router_service.dart';
import 'package:test_task_app/services/router/router_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:test_task_app/services/shared_preferences/shared_prefs.dart';
import 'package:test_task_app/services/shared_preferences/shared_prefs_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //VM
  serviceLocator.registerFactory(
    () => HomeVM(
      appRouter: serviceLocator(),
      viewRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => ListVM(
      appRouter: serviceLocator(),
      viewRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactoryParam<ItemVM, CharacterModel, void>(
    (character, _) => ItemVM(
      appRouter: serviceLocator(),
      viewRepository: serviceLocator(),
      character: character,
    ),
  );

  //Api
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => Logger());

  serviceLocator.registerFactory(() => ViewApi(serviceLocator()));

  //Repository
  serviceLocator.registerLazySingleton<ViewRepository>(
    () => ViewRepositoryImpl(
      viewApi: serviceLocator(),
      logger: serviceLocator(),
      sharedPrefs: serviceLocator(),
    ),
  );
    final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPrefs>(
    () => SharedPrefsImpl(sharedPreferences: sharedPrefs),
  );
  //Services
  serviceLocator.registerLazySingleton<AppRouter>(
    () => AppRouterImpl(),
  );
}
