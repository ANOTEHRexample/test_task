import 'package:test_task_app/common/base/base_vm.dart';
import 'package:test_task_app/data/models/character_model.dart';
import 'package:test_task_app/data/view/repository/view_repository.dart';
import 'package:test_task_app/services/router/router_service.dart';

class ItemVM extends BaseVM {
  AppRouter appRouter;
  ViewRepository viewRepository;
  CharacterModel character;

  ItemVM({
    required this.appRouter,
    required this.viewRepository,
    required this.character,
  });
}
