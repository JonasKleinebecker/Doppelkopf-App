import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

import 'Player.dart';

class Round {
  //List<Player> playersContra;
  //List<Player> playersRe;
  List<Player> spectators;
  List<Player> winners = [];

  Player dealer;
  Team winningTeam;
  Solo soloPlayed = Solo.none;
  bool bockrunde = false;

  int winningTeamPoints = 120;
  int announcementsRe = 120;
  int announcementsContra = 120;
  int gesprochenRe = 0;
  int gesprochenContra = 0;

  List<ExtraPoint> extraPointsRe = [];
  List<ExtraPoint> extraPointsContra = [];

  int roundValue;

  int calculateRoundValue() {
    int roundValue = 0;
    int announcementsWinningTeam;
    int announcementsLoosingTeam;
    List<ExtraPoint> extraPointsWinningTeam;
    List<ExtraPoint> extraPointsLoosingTeam;

    if (winningTeam == Team.re) {
      announcementsWinningTeam = announcementsRe;
      announcementsLoosingTeam = announcementsContra;

      extraPointsWinningTeam = extraPointsRe;
      extraPointsLoosingTeam = extraPointsContra;
    } else {
      announcementsWinningTeam = announcementsContra;
      announcementsLoosingTeam = announcementsRe;

      extraPointsWinningTeam = extraPointsContra;
      extraPointsLoosingTeam = extraPointsRe;
    }
    //Startpunkt für die extraPunkte Berechnung durch Punkte bestimmen
    if (soloPlayed == Solo.none) {
      if (winningTeam == Team.draw) {
        return 0;
      }
      roundValue = 1; //ein Punkt fürs gewinnen gibts immer

      roundValue += (winningTeamPoints - announcementsLoosingTeam) % 30;

      roundValue += ((announcementsWinningTeam - 120).abs().toInt()) ~/
          30; //Ansagen werden immer dem Gewinner zugerechnet, egal von wem Sie kommen

      roundValue += gesprochenRe;
      roundValue += gesprochenContra;

      roundValue -= extraPointsLoosingTeam.length;
      roundValue += extraPointsWinningTeam.length;

      if (bockrunde) {
        roundValue *= 2;
      }

      return roundValue;
    }
  }
}

enum ExtraPoint { fuchs, fuchsAmEnd, charlie, doppelkopf }

enum Team { re, contra, draw }

enum Solo { none, jack, queen, king, trump }

enum Announcement {
  re,
  reVorweg,
  contra,
  contraVorweg,
  keine90,
  keine60,
  keine30,
  schwarz,
}
