import 'dart:ffi';

import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

import 'Player.dart';

class Game {
  Map<Player, double> players;
  List<Round> rounds = [];

  Game(List<Player> players) {
    this.players = Map.fromIterable(players, key: (player) => player, value: (player) =>  0.0);
  }

  List<Round> getRounds() {
    return rounds;
  }
}
