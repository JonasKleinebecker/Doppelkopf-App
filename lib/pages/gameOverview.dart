import 'package:doppelkopf/classes/Game.dart';
import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

class GameOverview extends StatefulWidget {
  Game game;
  GameOverview(List<Player> activePlayers) {
    game = new Game(activePlayers);
  }

  @override
  _GameOverviewState createState() => _GameOverviewState();
}

class _GameOverviewState extends State<GameOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.game.getRounds().length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("test"));
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createAddRoundDialog();
          setState(() {});
        },
      ),
    );
  }

  Future<Round> createAddRoundDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter the new Round"),
            content: Column(
              children: [
                Text("Who won?"),
                CheckboxListTile(
                  value: false,
                  title: Text("Re"),
                  onChanged: (newValue) {},
                )
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }
}
