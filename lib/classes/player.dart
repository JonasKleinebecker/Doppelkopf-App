import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Player.g.dart';

@JsonSerializable()
class Player {
  String name;
  String age;
  int id;
  Player(String name, String age) {
    this.name = name;
    this.age = age;
  }

  String getName() {
    return name;
  }

  factory Player.fromJson(Map<String, dynamic> data) => _$PlayerFromJson(data);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
