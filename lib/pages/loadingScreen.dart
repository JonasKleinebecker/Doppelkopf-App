import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:doppelkopf/classes/GameController.dart';
import 'package:doppelkopf/classes/PlayerController.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([
      GameController.loadGames(),
      PlayerController.loadPlayers(),
    ]);
    Navigator.popAndPushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doppelkopf"),
      ),
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.grey,
        ),
      ),
    );
  }
}
