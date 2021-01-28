import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/startGame");
                    },
                    child: Text("New Game",
                        style: TextStyle(
                          color: Colors.grey[900],
                        )),
                  ),
                )
              ],
            )));
  }
}
