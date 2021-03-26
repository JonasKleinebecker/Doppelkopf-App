// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Round _$RoundFromJson(Map<String, dynamic> json) {
  return Round(
    (json['players'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..spectators = (json['spectators'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..winners = (json['winners'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..dealer = json['dealer'] == null
        ? null
        : Player.fromJson(json['dealer'] as Map<String, dynamic>)
    ..winningTeam = _$enumDecodeNullable(_$TeamEnumMap, json['winningTeam'])
    ..soloPlayed = _$enumDecodeNullable(_$SoloEnumMap, json['soloPlayed'])
    ..bockrunde = json['bockrunde'] as bool
    ..winningTeamPoints = json['winningTeamPoints'] as int
    ..announcementsRe = json['announcementsRe'] as int
    ..announcementsContra = json['announcementsContra'] as int
    ..gesprochenRe = json['gesprochenRe'] as int
    ..gesprochenContra = json['gesprochenContra'] as int
    ..extraPointsRe = (json['extraPointsRe'] as List)
        ?.map((e) => _$enumDecodeNullable(_$ExtraPointEnumMap, e))
        ?.toList()
    ..extraPointsContra = (json['extraPointsContra'] as List)
        ?.map((e) => _$enumDecodeNullable(_$ExtraPointEnumMap, e))
        ?.toList()
    ..roundValue = json['roundValue'] as int;
}

Map<String, dynamic> _$RoundToJson(Round instance) => <String, dynamic>{
      'players': instance.players?.map((e) => e?.toJson())?.toList(),
      'spectators': instance.spectators?.map((e) => e?.toJson())?.toList(),
      'winners': instance.winners?.map((e) => e?.toJson())?.toList(),
      'dealer': instance.dealer?.toJson(),
      'winningTeam': _$TeamEnumMap[instance.winningTeam],
      'soloPlayed': _$SoloEnumMap[instance.soloPlayed],
      'bockrunde': instance.bockrunde,
      'winningTeamPoints': instance.winningTeamPoints,
      'announcementsRe': instance.announcementsRe,
      'announcementsContra': instance.announcementsContra,
      'gesprochenRe': instance.gesprochenRe,
      'gesprochenContra': instance.gesprochenContra,
      'extraPointsRe':
          instance.extraPointsRe?.map((e) => _$ExtraPointEnumMap[e])?.toList(),
      'extraPointsContra': instance.extraPointsContra
          ?.map((e) => _$ExtraPointEnumMap[e])
          ?.toList(),
      'roundValue': instance.roundValue,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TeamEnumMap = {
  Team.re: 're',
  Team.contra: 'contra',
  Team.draw: 'draw',
};

const _$SoloEnumMap = {
  Solo.none: 'none',
  Solo.jack: 'jack',
  Solo.queen: 'queen',
  Solo.king: 'king',
  Solo.trump: 'trump',
};

const _$ExtraPointEnumMap = {
  ExtraPoint.fuchs: 'fuchs',
  ExtraPoint.fuchsAmEnd: 'fuchsAmEnd',
  ExtraPoint.charlie: 'charlie',
  ExtraPoint.doppelkopf: 'doppelkopf',
};
