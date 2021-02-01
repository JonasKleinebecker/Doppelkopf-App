import 'dart:convert';

import 'package:doppelkopf/classes/player.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  List<Player> playerList = [];

  Future<Player> createAddPlayerDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    Future<Player> getPlayerFromSharedPreferences(String playerName) async {
      final prefs = await SharedPreferences.getInstance();
      return Player.fromJson(json.decode(prefs.getString(playerName)));
    }

    void savePlayerToSharedPreferences(Player player) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(player.getName(), json.encode(player.toJson()));
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter the Players Details."),
            content: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: "Age",
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(Player(
                        nameController.text.toString(),
                        ageController.text.toString()));
                  },
                  child: Text("Submit"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
      ),
      body: Column(
        children: playerList.map((player) => Text(player.name)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createAddPlayerDialog(context).then((onValue) {
            setState(() {
              playerList.add(onValue);
            });
          });
        },
      ),
    );
  }
}
