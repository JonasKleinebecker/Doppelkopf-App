import 'dart:convert';

import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Game.dart';

class GameController {
  static List<Game> games = [];
  static List<Game> get getGames => GameController.games;

  static set setGames(List<Game> setGames) => games = setGames;

  static void addGame(Game game) {
    games.add(game);
    saveGames();
  }

  static Future<void> saveGames() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> gameMaps =
        games.map((game) => game.toJson()).toList();
    String gamesString = json.encode(gameMaps);
    prefs.setString("Games", gamesString);
  }

  static Future<void> loadGames() async {
    final prefs = await SharedPreferences.getInstance();
    String prefsString = prefs.getString("Games");
    if (prefsString != null) {
      List gameStrings = json.decode(prefsString);
      games = gameStrings.map((game) => Game.fromJson(game)).toList();
    }
  }

  static void removeGame(Game game) {
    games.remove(game);
    saveGames();
  }
}
