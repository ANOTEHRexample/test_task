import 'package:test_task_app/common/base/base_vm.dart';
import 'package:test_task_app/data/models/character_model.dart';
import 'package:test_task_app/data/view/repository/view_repository.dart';
import 'package:test_task_app/routers/screen_names.dart';
import 'package:test_task_app/services/router/router_service.dart';
import 'package:flutter/foundation.dart';

class ListVM extends BaseVM {
  AppRouter appRouter;
  ViewRepository viewRepository;
  List<CharacterModel> characters = [];
  List<CharacterModel> searchResult = [];

  int currentIndex = 0;

  int totalAttempts = 0;
  int successAttempts = 0;
  int failedAttempts = 0;

  ListVM({
    required this.appRouter,
    required this.viewRepository,
  }) {
    loadMainPage();
  }

  navigateToItemPage(CharacterModel item) {
    appRouter.pushNamed(name: ScreenNames.item, arguments: item);
  }

  onSearchChanged(String value) {
    if (value.length > 2) {
      searchResult = characters.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    }
    notifyListeners();
  }

  _countGeneralAttempts() {
    for (var element in characters) {
        if (element.totalAttempt > 0) {
          totalAttempts += element.totalAttempt;
          successAttempts += element.successAttempt;
          failedAttempts += element.failedAttempt;
        }
      }
  }

  loadMainPage() async {
    setLoading(true);
    try {
      characters = viewRepository.getCharactersFromSharedPreferences();
      if (characters.isEmpty) {
        characters = await viewRepository.getCharacters();
      }
      _addGuessedCharacters();
      _countGeneralAttempts();
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }
    setLoading(false);
  }

  _addGuessedCharacters() {
    searchResult = characters.where((element) => element.totalAttempt > 0).toList();
    notifyListeners();
  }
}
