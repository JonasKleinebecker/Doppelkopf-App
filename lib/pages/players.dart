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
  List<Player> playerList = [];

  void setPlayersFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String serializedPlayerList = prefs.getString("playerList");
    if (serializedPlayerList != null) {
      List playerStrings = json.decode(serializedPlayerList);
      playerList =
          playerStrings.map((player) => Player.fromJson(player)).toList();
      setState(() {});
    }
  }

  void savePlayersToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> playerStrings =
        playerList.map((player) => player.toJson()).toList();
    prefs.setString("playerList", json.encode(playerStrings));
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
    super.initState();
    setPlayersFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: playerList != null ? playerList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(),
            title: Text(playerList[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline_rounded),
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
