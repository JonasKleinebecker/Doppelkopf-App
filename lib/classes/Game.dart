import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/classes/Player.dart';

class Game {
  Map<Player, double> players;
  List<Round> rounds = List.empty(growable: true);

  Game(List<Player> players) {
    this.players = Map.fromIterable(players,
        key: (player) => player, value: (player) => 0.0);
  }

  List<Round> getRounds() {
    return rounds;
  }

  void intregrateRound(round) {
    Map<Player, double> incomes;

    rounds.add(round);
    incomes = round.getPlayerIncomes();
    incomes.forEach((key, value) {
      players[key] += value;
    });
  }
}
