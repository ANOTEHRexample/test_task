// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      house: json['house'] as String,
      image: json['image'] as String,
      actor: json['actor'] as String,
      species: json['species'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
      isGuessed: json['isGuessed'] as bool? ?? false,
      totalAttempt: json['totalAttempt'] as int? ?? 0,
      successAttempt: json['successAttempt'] as int? ?? 0,
      failedAttempt: json['failedAttempt'] as int? ?? 0,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'house': instance.house,
      'image': instance.image,
      'actor': instance.actor,
      'species': instance.species,
      'dateOfBirth': instance.dateOfBirth,
      'isGuessed': instance.isGuessed,
      'totalAttempt': instance.totalAttempt,
      'successAttempt': instance.successAttempt,
      'failedAttempt': instance.failedAttempt,
    };
