import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

class Player {
  String name;
  String age;
  Player(String name, String age) {
    this.name = name;
    this.age = age;
  }

  Player.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        age = json["age"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
      };

  String getName() {
    return name;
  }
}
