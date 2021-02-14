import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/PlayerHandler.dart';
import 'package:flutter/material.dart';

class StartGame extends StatefulWidget {
  List<Player> activePlayers;

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
                          //TODO
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            createAddPlayersDialog();
          },
          child: Text("Add Players")),
    );
  }

  void loadPlayerList() async {
    await PlayerHandler.setPlayersFromSharedPreferences(); //TODO: Refactor!
    setState(() {
      //!hässlich
    });
  }

  createAddPlayersDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Choose Players"),
            content:Container(
              width: 350,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: PlayerHandler.getPlayerList != null
                    ? PlayerHandler.getPlayerList.length
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                  leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey[800],
                  child: Text(PlayerHandler.getPlayerList[index].name
                  .substring(0, 1)),
                  ),
                  title: Text(PlayerHandler.getPlayerList[index].name),
                  trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                  //TODO
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
}
