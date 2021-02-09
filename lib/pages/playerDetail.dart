import 'package:doppelkopf/classes/player.dart';
import 'package:flutter/material.dart';

class playerDetail extends StatelessWidget {
  final Player player;

  playerDetail(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          Text(player.name),
          Text(player.age),
        ],
      ),
    ));
  }
}
