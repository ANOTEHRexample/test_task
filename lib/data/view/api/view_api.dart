import 'package:test_task_app/constants/app_host.dart';
import 'package:test_task_app/data/models/character_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'view_api.g.dart';

@RestApi(baseUrl: AppHost.host)
abstract class ViewApi {
  factory ViewApi(Dio dio, {String baseUrl}) = _ViewApi;

  @GET('/characters')
  Future<List<CharacterModel>> getCharacters();
}
