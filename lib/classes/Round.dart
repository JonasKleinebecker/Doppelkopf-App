import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

import 'Player.dart';

class Round {
  List<Player> playersContra;
  List<Player> playersRe;
  List<Player> spectators;

  Player dealer;
  Team winningTeam;
  Solo soloPlayed;
  bool bockrunde;

  int winningTeamPoints;
  List<Announcement> announcementsWinningTeam;
  List<Announcement> announcementsLoosingTeam;

  List<ExtraPoint> extraPointsWinningTeam;
  List<ExtraPoint> extraPointsLoosingTeam;

  int roundValue;

  int calculateRoundValue() {
    int roundValue = 0;
    int scoreToWin = 121;

    //Startpunkt für die extraPunkte Berechnung durch Punkte bestimmen
    if (extraPointsLoosingTeam.contains(Announcement.schwarz)) {
      scoreToWin = 1;
    } else if (extraPointsLoosingTeam.contains(Announcement.keine30)) {
      scoreToWin = 30;
    } else if (extraPointsLoosingTeam.contains(Announcement.keine60)) {
      scoreToWin = 60;
    } else if (extraPointsLoosingTeam.contains(Announcement.keine90)) {
      scoreToWin = 90;
    }

    if (soloPlayed == Solo.none) {
      if (winningTeam == Team.draw) {
        return 0;
      }

      roundValue = (winningTeamPoints - scoreToWin) %
          30; //pro 30 Punkte über dem Score to Win gibt es einen Extra Punkt
      extraPointsLoosingTeam.map((extraPoint) =>
          extraPoint == ExtraPoint.fuchsAmEnd ? roundValue -= 2 : roundValue--);
      extraPointsWinningTeam.map((extraPoint) =>
          extraPoint == ExtraPoint.fuchsAmEnd ? roundValue += 2 : roundValue++);

      roundValue += announcementsWinningTeam.length;
      roundValue += announcementsLoosingTeam.length;

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
