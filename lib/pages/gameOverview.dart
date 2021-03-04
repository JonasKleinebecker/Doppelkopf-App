import 'package:doppelkopf/classes/Game.dart';
import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

class GameOverview extends StatefulWidget {
  Game game;
  GameOverview(List<Player> activePlayers) {
    game = new Game(activePlayers);
  }

  @override
  _GameOverviewState createState() => _GameOverviewState();
}

class _GameOverviewState extends State<GameOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.game.getRounds().length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("test"));
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createAddRoundDialog();
          setState(() {});
        },
      ),
    );
  }

  Future<Round> createAddRoundDialog() {
    Round round = Round();

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Enter the new Round"),
              content: Column(
                children: [
                  Text("Who won?"),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        child: CheckboxListTile(
                          value: round.winningTeam == Team.re ? true : false,
                          title: Text("Re"),
                          onChanged: (newValue) {
                            setStateDialog(() {
                              if (newValue) {
                                round.winningTeam = Team.re;
                              } else {
                                round.winningTeam = null;
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        child: CheckboxListTile(
                          value:
                              round.winningTeam == Team.contra ? true : false,
                          title: Text("Contra"),
                          onChanged: (newValue) {
                            setStateDialog(() {
                              if (newValue) {
                                round.winningTeam = Team.contra;
                              } else {
                                round.winningTeam = null;
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 100,
                          child: CheckboxListTile(
                              value:
                                  round.winningTeam == Team.draw ? true : false,
                              title: Text("Draw"),
                              onChanged: (newValue) {
                                setStateDialog(() {
                                  if (newValue) {
                                    round.winningTeam = Team.draw;
                                  } else {
                                    round.winningTeam = null;
                                  }
                                });
                              }))
                    ],
                  ),
                  Text("Ansagen Re:"),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        child: CheckboxListTile(
                            value: round.gesprochenRe > 0 ? true : false,
                            title: Text("Re"),
                            onChanged: (newValue) {
                              setStateDialog(() {
                                if (newValue) {
                                  round.gesprochenRe = 1;
                                } else {
                                  round.gesprochenRe = 0;
                                }
                              });
                            }),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: CheckboxListTile(
                            value: round.gesprochenRe == 2 ? true : false,
                            title: Text("Vorweg"),
                            onChanged: (newValue) {
                              setStateDialog(() {
                                if (newValue) {
                                  round.gesprochenRe = 2;
                                } else {
                                  round.gesprochenRe = 1;
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                  Slider(
                    onChanged: (selectedValue) {
                      setStateDialog(() => round
                          .announcementsRe = (selectedValue -
                              120)
                          .abs()
                          .toInt()); // -120 und dann Betrag ziehen, ermöglicht die Anzeige von hoch nach niedrig
                      print(round.announcementsRe);
                    },
                    min: 0,
                    max: 120,
                    divisions: 4,
                    value: (round.announcementsRe - 120)
                        .abs()
                        .toDouble(), // -120 und dann Betrag ziehen ermöglicht das anzeigen von hoch nach niedrig
                    label: generateAnnouncementsLabel(Team.re, round),
                  ),
                  Text("Ansagen Contra:"),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        child: CheckboxListTile(
                            value: round.gesprochenContra > 0 ? true : false,
                            title: Text("Re"),
                            onChanged: (newValue) {
                              setStateDialog(() {
                                if (newValue) {
                                  round.gesprochenContra = 1;
                                } else {
                                  round.gesprochenContra = 0;
                                }
                              });
                            }),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: CheckboxListTile(
                            value: round.gesprochenContra == 2 ? true : false,
                            title: Text("Vorweg"),
                            onChanged: (newValue) {
                              setStateDialog(() {
                                if (newValue) {
                                  round.gesprochenContra = 2;
                                } else {
                                  round.gesprochenContra = 1;
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                  Slider(
                    onChanged: (selectedValue) {
                      setStateDialog(() => round
                          .announcementsContra = (selectedValue -
                              120)
                          .abs()
                          .toInt()); // -120 und dann Betrag ziehen, ermöglicht die Anzeige von hoch nach niedrig
                      print(round.announcementsContra);
                    },
                    min: 0,
                    max: 120,
                    divisions: 4,
                    value: (round.announcementsContra - 120)
                        .abs()
                        .toDouble(), // -120 und dann Betrag ziehen ermöglicht das anzeigen von hoch nach niedrig
                    label: generateAnnouncementsLabel(Team.contra, round),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Submit")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    child: Text("Cancel"))
              ],
            );
          });
        });
  }

  String generateAnnouncementsLabel(Team team, Round round) {
    int announcements;

    if (team == Team.contra) {
      announcements = round.announcementsContra;
    } else {
      announcements = round.announcementsRe;
    }

    if (announcements == 0) {
      return "schwarz";
    } else if (announcements == 120) {
      return "-";
    } else {
      return "keine $announcements";
    }
  }
}
