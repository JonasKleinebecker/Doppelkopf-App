// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    (json['players'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..playerScores = (json['playerScores'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), (e as num)?.toDouble()),
    )
    ..date = json['date'] as String
    ..rounds = (json['rounds'] as List)
        ?.map(
            (e) => e == null ? null : Round.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'players': instance.players?.map((e) => e?.toJson())?.toList(),
      'playerScores':
          instance.playerScores?.map((k, e) => MapEntry(k.toString(), e)),
      'date': instance.date,
      'rounds': instance.rounds?.map((e) => e?.toJson())?.toList(),
    };
