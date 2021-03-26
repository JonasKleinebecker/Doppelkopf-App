import 'package:doppelkopf/classes/Game.dart';
import 'package:doppelkopf/classes/GameController.dart';
import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/customWidgets/CustomCheckbox.dart';
import 'package:doppelkopf/pages/gameOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Doppelkopf"),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.bar_chart), onPressed: () {}),
                IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.pushNamed(context, "/players");
                    }),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                  child:
                      IconButton(icon: Icon(Icons.settings), onPressed: () {}),
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: GameController.getGames.length,
                      itemBuilder: (context, index) =>
                          generateRoundCard(index)),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/startGame")
                          .then((value) => setState(() {}));
                    },
                    child: Text("New Game",
                        style: TextStyle(
                          color: Colors.grey[900],
                        )),
                  ),
                ),
              ],
            )));
  }

  generateRoundCard(int index) {
    Game game = GameController.getGames[index];
    List<Player> players = game.players;
    Map<int, double> playerScores = game.playerScores;

    List<Widget> widgets = [];

    double playerScore;

    for (int i = 0; i < players.length; i++) {
      Player player = players[i];
      playerScore = playerScores[player.id];

      List<Widget> rowContent = [];

      if (i >= (players.length - 1)) {
        rowContent.add(
          Container(
              width: 45,
              decoration: BoxDecoration(
                border: Border.all(),
                color: playerScore < 0 ? Colors.redAccent : Colors.lightGreen,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Center(child: Text(playerScore.toString()))),
        );
      } else {
        rowContent.add(
          Container(
              width: 45,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors
                    .lightGreen, //playerScore < 0 ? Colors.redAccent : Colors.lightGreen,
                borderRadius: BorderRadius.circular(7.0),
              ),
              child: Center(child: Text(playerScore.toString()))),
        );
        rowContent.add(VerticalDivider(
          color: Colors.grey[900],
          thickness: 1.5,
        ));
      }

      widgets.add(
        Expanded(
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rowContent,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 10, 0),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        secondaryActions: [
          IconSlideAction(
              icon: Icons.delete,
              color: Colors.red,
              onTap: () {
                createConfirmGameDeletionDialog(context, game).then(
                  (value) =>                 setState(() {})

                );
              })
        ],
        child: Card(
          elevation: 8.0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GameOverview(game)));
                },
                contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 22),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widgets,
                )),
          ),
        ),
      ),
    );
  }

  Future<bool> createConfirmGameDeletionDialog(BuildContext context, Game game) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Confirm Deletion"),
            content: Text("Do you really want to delete this game?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    GameController.removeGame(game);
                    Navigator.of(context)
                        .pop(true); // return true if palyer was deleted
                  },
                  child: Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // return false if player wasnt deleted
                  },
                  child: Text("No"))
            ],
          );
        });
  }
}
