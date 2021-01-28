import 'package:doppelkopf/classes/player.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

class Players extends StatefulWidget {
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  List<Player> playerList = [];

  Future<String> createAddPlayerDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) { 
          return AlertDialog(
            title: Text("Enter the Players Name"),
            content: TextField(
              controller: controller,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.text.toString());
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
              playerList.add(Player(onValue));
            });
          });
        },
      ),
    );
  }
}
