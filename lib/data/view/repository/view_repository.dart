import 'package:test_task_app/data/models/character_model.dart';

abstract class ViewRepository {
 Future<List<CharacterModel>> getCharacters();
 List<CharacterModel> getCharactersFromSharedPreferences();
 void setCharactersToSharedPreferences(List<CharacterModel> characters);
}
