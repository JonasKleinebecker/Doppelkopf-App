import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Player.dart';

class PlayerController {
  static List<Player> playerList = [];
  static bool isLoaded = false;

  static List<Player> get getPlayerList{
    return playerList;
  }

  static set setPlayerList(List playerList) =>
      PlayerController.playerList = playerList;

  static Future<void> loadPlayers() async {
    isLoaded = true;

    final prefs = await SharedPreferences.getInstance();
    String serializedPlayerList = prefs.getString("playerList");
    if (serializedPlayerList != null) {
      List playerStrings = json.decode(serializedPlayerList);
      playerList =
          playerStrings.map((player) => Player.fromJson(player)).toList();
    }
  }

  static void savePlayers() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> playerStrings =
        playerList.map((player) => player.toJson()).toList();
    prefs.setString("playerList", json.encode(playerStrings));
  }

  static void deletePlayer(Player player) {
    for (int i = 0; i < playerList.length; i++) {
      if (player == playerList[i]) {
        playerList.removeAt(i);
      }
    }
    savePlayers();
  }
}
