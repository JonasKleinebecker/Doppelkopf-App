import 'package:doppelkopf/classes/Game.dart';
import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/customWidgets/CustomCheckbox.dart';
import 'package:doppelkopf/pages/players.dart';
import 'package:flutter/material.dart';
import 'package:doppelkopf/pages/home.dart';
import 'package:doppelkopf/pages/startGame.dart';

class GameOverview extends StatefulWidget {
  Game game;

  List<String> fuchsImagePaths = [
    "assets/images/Ace_Of_Diamonds_greyed_out.svg",
    "assets/images/Ace_Of_Diamonds.svg",
    "assets/images/Ace_Of_Diamonds_plus_plus.svg"
  ];

  List<String> charlieImagePaths = [
    "assets/images/Jack_Of_Clubs_greyed_out.svg",
    "assets/images/Jack_Of_Clubs.svg"
  ];

  List<String> doppelkopfImagePaths = [
    "assets/images/4erDoppelkopf_greyed_out.svg",
    "assets/images/4erDoppelkopf.svg"
  ];
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
            double customCheckboxWidth = 80;
            double customCheckboxHeight = 85;

            return AlertDialog(
              title: Text("Enter the new Round"),
              content: Column(children: [
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
                        value: round.winningTeam == Team.contra ? true : false,
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
                          title: Text("Contra"),
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
                  },
                  min: 0,
                  max: 120,
                  divisions: 4,
                  value: (round.announcementsContra - 120)
                      .abs()
                      .toDouble(), // -120 und dann Betrag ziehen ermöglicht das anzeigen von hoch nach niedrig
                  label: generateAnnouncementsLabel(Team.contra, round),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Re"), Text("Contra")],
                ),
                Text("Fuchs"),
                Padding(
                  padding: const EdgeInsets.only(left: 23.63),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                           Container(
                            width: customCheckboxWidth,
                            height: customCheckboxHeight,
                            child: CustomCheckbox(
                              onTap: () {
                                switch (extraPointsToCheckBoxValue(
                                    round, ExtraPoint.fuchs, Team.re, 0)) {
                                  case 0:
                                    {
                                      round.extraPointsRe.add(ExtraPoint.fuchs);
                                    }
                                    break;
                                  case 1:
                                    {
                                      round.extraPointsRe
                                          .add(ExtraPoint.fuchsAmEnd);
                                    }
                                    break;
                                  case 2:
                                    {
                                      round.extraPointsRe.remove(ExtraPoint.fuchs);
                                      round.extraPointsRe
                                          .remove(ExtraPoint.fuchsAmEnd);
                                    }
                                    break;
                                }
                                setStateDialog(() {});
                              },
                              value: extraPointsToCheckBoxValue(
                                  round, ExtraPoint.fuchs, Team.re, 0),
                              imagePaths: widget.fuchsImagePaths,
                            ),
                          ),
 
                        Container(
                          width: customCheckboxWidth,
                          height: customCheckboxHeight,
                          child: CustomCheckbox(
                            onTap: () {
                              switch (extraPointsToCheckBoxValue(
                                  round, ExtraPoint.fuchs, Team.contra, 0)) {
                                case 0:
                                  {
                                    round.extraPointsContra.add(ExtraPoint.fuchs);
                                  }
                                  break;
                                case 1:
                                  {
                                    round.extraPointsContra
                                        .add(ExtraPoint.fuchsAmEnd);
                                  }
                                  break;
                                case 2:
                                  {
                                    round.extraPointsContra
                                        .remove(ExtraPoint.fuchs);
                                    round.extraPointsContra
                                        .remove(ExtraPoint.fuchsAmEnd);
                                  }
                                  break;
                              }
                              setStateDialog(() {});
                            },
                            value: extraPointsToCheckBoxValue(
                                round, ExtraPoint.fuchs, Team.contra, 0),
                            imagePaths: widget.fuchsImagePaths,
                          ),
                        ),
                      ]),
                ),
                Text("Doppelkopf"),
                Padding(
                  padding: const EdgeInsets.only(left: 23.63),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: customCheckboxWidth,
                        height: customCheckboxHeight ,
                        child: CustomCheckbox(
                          onTap: () {
                            switch (extraPointsToCheckBoxValue(
                                round, ExtraPoint.doppelkopf, Team.re, 0)) {
                              case 0:
                                {
                                  round.extraPointsRe.add(ExtraPoint.doppelkopf);
                                }
                                break;
                              case 1:
                                {
                                  round.extraPointsRe
                                      .remove(ExtraPoint.doppelkopf);
                                }
                                break;
                            }
                            setStateDialog(() {});
                          },
                          value: extraPointsToCheckBoxValue(
                              round, ExtraPoint.doppelkopf, Team.re, 0),
                          imagePaths: widget.doppelkopfImagePaths,
                        ),
                      ),
                      Container(
                        width: customCheckboxWidth,
                        height: customCheckboxHeight,
                        child: CustomCheckbox(
                          onTap: () {
                            switch (extraPointsToCheckBoxValue(
                                round, ExtraPoint.doppelkopf, Team.contra, 0)) {
                              case 0:
                                {
                                  round.extraPointsContra
                                      .add(ExtraPoint.doppelkopf);
                                }
                                break;
                              case 1:
                                {
                                  round.extraPointsContra
                                      .remove(ExtraPoint.doppelkopf);
                                }
                                break;
                            }
                            setStateDialog(() {});
                          },
                          value: extraPointsToCheckBoxValue(
                              round, ExtraPoint.doppelkopf, Team.contra, 0),
                          imagePaths: widget.doppelkopfImagePaths,
                        ),
                      )
                    ],
                  ),
                ),
                Text("Charlie am End"),
                Padding(
                  padding: const EdgeInsets.only(left: 23.63),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: customCheckboxWidth,
                        height: customCheckboxHeight,
                        child: CustomCheckbox(
                          onTap: () {
                            switch (extraPointsToCheckBoxValue(
                                round, ExtraPoint.charlie, Team.re, 0)) {
                              case 0:
                                {
                                  round.extraPointsRe.add(ExtraPoint.charlie);
                                }
                                break;
                              case 1:
                                {
                                  round.extraPointsRe.remove(ExtraPoint.charlie);
                                }
                                break;
                            }
                            setStateDialog(() {});
                          },
                          value: extraPointsToCheckBoxValue(
                              round, ExtraPoint.charlie, Team.re, 0),
                          imagePaths: widget.charlieImagePaths,
                        ),
                      ),
                      Container(
                        width: customCheckboxWidth,
                        height: customCheckboxHeight,
                        child: CustomCheckbox(
                          onTap: () {
                            switch (extraPointsToCheckBoxValue(
                                round, ExtraPoint.charlie, Team.contra, 0)) {
                              case 0:
                                {
                                  round.extraPointsContra.add(ExtraPoint.charlie);
                                }
                                break;
                              case 1:
                                {
                                  round.extraPointsContra
                                      .remove(ExtraPoint.charlie);
                                }
                                break;
                            }
                            setStateDialog(() {});
                          },
                          value: extraPointsToCheckBoxValue(
                              round, ExtraPoint.charlie, Team.contra, 0),
                          imagePaths: widget.charlieImagePaths,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
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

  int extraPointsToCheckBoxValue(
      Round round, ExtraPoint extraPoint, Team team, int i) {
    // gibt eine Wert zurück, mit dem die Fuchs-Checkboxen ihren State ändern
    List<ExtraPoint> extraPoints;

    if (team == Team.re) {
      extraPoints = round.extraPointsRe;
    } else {
      extraPoints = round.extraPointsContra;
    }

    //wie oft ist der extraPoint in extraPoints ?
    if (extraPoints
            .where((element) =>
                element ==
                extraPoint) //finde alle Einträge von extraPoint in extraPoints
            .toList() //mache aus diesen Einträgen eine neue Liste
            .length >
        (i)) {
      // und überprüfe die Länge. i gibt an, für den wievielten extraPoint wir überprüfen (z.B. der zweite Fuchs, der dritte Doppelkopf etc.)

      //wenn der extraPoint ein Fuchs ist, wird zusätzlich nach Fuchs am End gesucht
      if (extraPoint == ExtraPoint.fuchs) {
        if (extraPoints
                .where((element) =>
                    element ==
                    ExtraPoint
                        .fuchsAmEnd) // selber Aufbau wie oben. Diesmal hardgecoded mit Fuchs am Emd
                .toList()
                .length >
            i) {
          return 2; // wrd nur bei Fuchs am End zurückgegeben

        } else {
          return 1;
        }
      } else {
        return 1; // die zu überprüfende Checkbox soll aktiviert dargestellt werden
      }
    } else {
      return 0; // die zu überprüfende Checkbox soll inaktiv dargestellt werden
    }
  }
}
