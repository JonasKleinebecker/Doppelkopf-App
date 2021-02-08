import 'dart:convert';

import 'package:doppelkopf/classes/player.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';
import 'package:gson/gson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:type_token/type_token.dart';

class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  List<Player> playerList;

  Future <List<Player>> getPlayersFromSharedPreferences() async{
    final prefs = SharedPreferences.getInstance();
    String serializedPlayerList = prefs.getString("playerList"); //TODO Fix this
    if (serializedPlayerList != null) {
      List playerStrings = json.decode(serializedPlayerList);
      return playerStrings.map((player) => Player.fromJson(player)).toList();
    }
  }

  void savePlayersToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<String dynamic> jsons = playerList.map((player) => player.toJson()).toList();
    prefs.setString("playerList", json.encode(jsons));
}

  Future<Player> createAddPlayerDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

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

  void initState() {
   
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
              savePlayersToSharedPreferences();
            });
          });
        },
      ),
    );
  }
}
