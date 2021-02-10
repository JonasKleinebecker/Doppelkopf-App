import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/PlayerHandler.dart';
import 'package:flutter/material.dart';

class playerDetail extends StatefulWidget {
  Player player;
  playerDetail(this.player);

  @override
  _playerDetailState createState() => _playerDetailState();
}

class _playerDetailState extends State<playerDetail> {
  Future<Player> createEditPlayerDialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Player: ${widget.player.name}"),
        ),
        body: Center(
          child: Column(
            children: [
              Text(widget.player.name),
              Text(widget.player.age),
              ElevatedButton(
                  onPressed: () {
                    createEditPlayerDialog(context).then((onValue) {
                      widget.player.name = onValue.name;
                      widget.player.age = onValue.age;

                      setState(() {});
                    });
                  },
                  child: Text("Edit")),
              ElevatedButton(
                  onPressed: () {
                    createDeletePlayerConfirmationDialog();
                  },
                  child: Text("Delete"))
            ],
          ),
        ));
  }

  createDeletePlayerConfirmationDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter the Players Details."),
            content: Text("Do you want to delete Player ${widget.player.name}"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    PlayerHandler.deletePlayer(widget.player);
                    Navigator.pop(context);
                  },
                  child: Text("Yes"))
            ],
          );
        });
  }
}
