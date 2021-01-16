import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';
void main() => runApp(MaterialApp(
  initialRoute: "/home",
  routes: {
    "/home": (context) => Home(),
    "/startGame": (context) => StartGame(),
  },
  )
);