import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

import 'Player.dart';

class Round {
  List<Player> playersContra;
  List<Player> playersRe;
  List<Player> spectators;
  List<Player> winners = [];

  Player dealer;
  Team winningTeam;
  Solo soloPlayed;
  bool bockrunde;

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
    int scoreToWin = 121;
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
    scoreToWin = announcementsWinningTeam + 1; //TODO: Berechnung

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
