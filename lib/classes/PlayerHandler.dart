import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Player.dart';

class PlayerHandler {
  static List<Player> playerList = [];

  static List<Player> get getPlayerList => playerList;

  static set setPlayerList(List playerList) =>
      PlayerHandler.playerList = playerList;

  static Future<void> setPlayersFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String serializedPlayerList = prefs.getString("playerList");
    if (serializedPlayerList != null) {
      List playerStrings = json.decode(serializedPlayerList);
      playerList =    
          playerStrings.map((player) => Player.fromJson(player)).toList();
    }
  }

  static void savePlayersToSharedPreferences() async {
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
    savePlayersToSharedPreferences();
  }
}
