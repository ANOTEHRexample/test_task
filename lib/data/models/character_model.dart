import 'package:json_annotation/json_annotation.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  final String id;
  final String name;
  final String house;
  final String image;
  final String actor;
  final String species;
  final String? dateOfBirth;
  bool isGuessed;
  int totalAttempt;
  int successAttempt;
  int failedAttempt;

  CharacterModel({
    required this.id,
    required this.name,
    required this.house,
    required this.image,
    required this.actor,
    required this.species,
    required this.dateOfBirth,
    this.isGuessed = false,
    this.totalAttempt = 0,
    this.successAttempt = 0 ,
    this.failedAttempt = 0,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$GetCharactersResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCharactersResultsModelToJson(this);
}
