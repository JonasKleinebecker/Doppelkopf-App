// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    json['name'] as String,
    json['age'] as String,
  )..id = json['id'] as int;
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'id': instance.id,
    };
