import 'dart:convert';

import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/PlayerController.dart';
import 'package:doppelkopf/pages/playerDetail.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
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
                  Navigator.of(context).pop(null);
                },
                child: Text("Cancel"),
              ),
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
    loadPlayerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: PlayerController.getPlayerList != null
            ? PlayerController.getPlayerList.length
            : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey[800],
                child: Text(
                    PlayerController.getPlayerList[index].name.substring(0, 1)),
              ),
              title: Text(PlayerController.getPlayerList[index].name),
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return playerDetail(PlayerController.getPlayerList[index]);
                }));
                setState(() {}); //Reload if Back Button is pressed
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline_rounded),
        onPressed: () {
          createAddPlayerDialog(context).then((onValue) {
            setState(() {
              if (onValue != null) {
                PlayerController.getPlayerList.add(onValue);
                PlayerController.savePlayersToSharedPreferences();
              }
            });
          });
        },
      ),
    );
  }

  void loadPlayerList() async {
    await PlayerController.setPlayersFromSharedPreferences(); //TODO: Refactor!
    setState(() {
      //!hässlich
    });
  }
}
