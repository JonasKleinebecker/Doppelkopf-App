import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/PlayerController.dart';
import 'package:flutter/material.dart';

class StartGame extends StatefulWidget {
  List<Player> activePlayers = [];

  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  @override
  void initState() {
    super.initState();
    loadPlayerList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Game")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Players:",
              style: TextStyle(fontSize: 20.0),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: widget.activePlayers != null
                    ? widget.activePlayers.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey[800],
                      child: Text(
                          widget.activePlayers[index].name.substring(0, 1)),
                    ),
                    title: Text(widget.activePlayers[index].name),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          widget.activePlayers.removeAt(index);
                          setState(() {});
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                createAddPlayersDialog(context).then((onValue) {
                  if (onValue != null) {
                    widget.activePlayers.add(onValue);
                    setState(() {}); 
                  }
                });
              },
              child: Text("Add Players")),
          ElevatedButton(
              onPressed: (enoughPlayerAdded() ? ()=> startGame() : null),
              child: Text("Start Game"))
        ],
      ),
    );
  }

  void loadPlayerList() async {
    await PlayerController.setPlayersFromSharedPreferences(); //TODO: Refactor!
    setState(() {
      //!hässlich
    });
  }

  Future<Player> createAddPlayersDialog(BuildContext context) {
    List<Player> addeblePlayers =
        []; // does not contain Players, who have already been added
    addeblePlayers.addAll(PlayerController.getPlayerList);
    addeblePlayers
        .removeWhere((player) => widget.activePlayers.contains(player));
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose Players"),
            content: Container(
              width: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: addeblePlayers != null ? addeblePlayers.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey[800],
                      child: Text(addeblePlayers[index].name.substring(0, 1)),
                    ),
                    title: Text(addeblePlayers[index].name),
                    trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context).pop(addeblePlayers[index]);
                        }),
                  );
                },
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  bool enoughPlayerAdded() {
    if (widget.activePlayers.length >= 4) {
      return true;
    } else {
      return false;
    }
  }

  void startGame() {
    Navigator.of(context).popAndPushNamed(
      "/gameOverview",
      arguments: widget.activePlayers, 
    );
  }
}
