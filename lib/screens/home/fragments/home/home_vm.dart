import 'package:test_task_app/common/base/base_vm.dart';
import 'package:test_task_app/constants/app_string.dart';
import 'package:test_task_app/data/models/character_model.dart';
import 'package:test_task_app/data/models/house_model.dart';
import 'package:test_task_app/data/view/repository/view_repository.dart';
import 'package:test_task_app/routers/screen_names.dart';
import 'package:test_task_app/services/router/router_service.dart';
import 'package:flutter/foundation.dart';

class HomeVM extends BaseVM {
  AppRouter appRouter;
  ViewRepository viewRepository;
  List<CharacterModel> characters = [];
  bool isDataReceived = false;


  var houses = [
    House(name: AppString.gryffindor, assetImage: 'assets/houses/Gryffindor.png'),
    House(name: AppString.slytherin, assetImage: 'assets/houses/Slytherin.png'),
    House(name: AppString.ravenclaw, assetImage: 'assets/houses/Ravenclaw.png'),
    House(name: AppString.hufflepuff, assetImage: 'assets/houses/Hufflepuff.png'),
  ];


  late int characterIndex = 0;

  HomeVM({
    required this.appRouter,
    required this.viewRepository,
  }) {
    loadMainPage();
  }

  onResetButtonTap() {
    characters[characterIndex].totalAttempt = 0;
    characters[characterIndex].failedAttempt = 0;
    characters[characterIndex].successAttempt = 0;
    notifyListeners();
  }

  Future<void> onRefresh() async {
    increaseIndex();
    notifyListeners();
  }

  navigateToItemPage(CharacterModel item) {
    appRouter.pushNamed(name: ScreenNames.item, arguments: item);
  }

  increaseIndex() {
    if (characterIndex < characters.length) {
      characterIndex++;
    } else {
      characterIndex = 0;
    }
  }

  onHouseCellTap(House house) {
    characters[characterIndex].totalAttempt++;
    if (house.name == characters[characterIndex].house) {
      characters[characterIndex].successAttempt++;
      notifyListeners();
      return AppString.correct;
    } else {
      characters[characterIndex].failedAttempt++;
      return AppString.wrong;
    }
  }

  notInHouseButton() {
    characters[characterIndex].totalAttempt++;
    if (characters[characterIndex].house == '') {
      characters[characterIndex].successAttempt++;
      notifyListeners();
      return AppString.correct;
    } else {
      characters[characterIndex].failedAttempt++;
      return AppString.wrong;
    }
  }

  loadMainPage() async {
    setLoading(true);
    try {
      characters = viewRepository.getCharactersFromSharedPreferences();
      if (characters.isEmpty) {
        characters = await viewRepository.getCharacters();
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }
    setLoading(false);
  }

  saveDataOnTabChange() {
    viewRepository.setCharactersToSharedPreferences(characters);
  }
}
