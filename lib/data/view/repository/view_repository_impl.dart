import 'dart:convert';

import 'package:test_task_app/data/models/character_model.dart';
import 'package:test_task_app/data/view/api/view_api.dart';
import 'package:test_task_app/data/view/repository/view_repository.dart';
import 'package:logger/logger.dart';
import 'package:test_task_app/services/shared_preferences/shared_prefs.dart';

class ViewRepositoryImpl implements ViewRepository {
  ViewApi viewApi;
  Logger logger;
  SharedPrefs sharedPrefs;
  ViewRepositoryImpl({
    required this.viewApi,
    required this.logger,
    required this.sharedPrefs,
  });

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final res = await viewApi.getCharacters();
    return res;
  }

  @override
  void setCharactersToSharedPreferences(List<CharacterModel> characters) {
    var a = characters.map((character) => character.toJson()).toList();

    var jsonStringList = json.encode(a);
    sharedPrefs.setData(jsonStringList);
  }

  @override
  List<CharacterModel> getCharactersFromSharedPreferences() {
    String jsonStringList = sharedPrefs.getData();
    var res = json.decode(jsonStringList);

    List<CharacterModel> getCharactersResultsModel = List<CharacterModel>.from(
      res.map((character) {
        return CharacterModel.fromJson(character);
      }).toList(),
    );

    return getCharactersResultsModel;
  }
}
