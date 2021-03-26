import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/classes/Player.dart';
import 'package:json_annotation/json_annotation.dart';

import 'GameController.dart';

part 'Game.g.dart';

@JsonSerializable(explicitToJson: true)
class Game {
  int playersPerRound;
  List<Player> players = [];
  Map<int, double> playerScores = Map<int, double>();  //mapping Player.id to their Scores inside a game
  String date = DateTime.now().toString();

  List<Round> rounds = List.empty(growable: true);

  Game(List<Player> players) {
    this.players = players;
    for (Player player in players) {
      playerScores[player.id] = 0.0;
    }
    if (players.length > 5) {
      playersPerRound = 5;
    } else {
      playersPerRound = players.length;
    }
  }

  List<Round> getRounds() {
    return rounds;
  }

  void intregrateRound(round) {
    Map<Player, double> incomes;

    rounds.add(round);
    incomes = round.getPlayerIncomes();
    incomes.forEach((key, value) {
      playerScores[key.id] += value;
    });

    GameController.saveGames();
  }

  factory Game.fromJson(Map<String, dynamic> data) => _$GameFromJson(data);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
