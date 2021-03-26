import 'package:doppelkopf/classes/Game.dart';
import 'package:doppelkopf/classes/Player.dart';
import 'package:doppelkopf/classes/Round.dart';
import 'package:doppelkopf/customWidgets/CustomCheckbox.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class GameOverview extends StatefulWidget {
  final Game copyGame;

  final List<String> fuchsImagePaths = [
    "assets/images/Ace_Of_Diamonds_greyed_out.svg",
    "assets/images/Ace_Of_Diamonds.svg",
    "assets/images/Ace_Of_Diamonds_plus_plus.svg"
  ];

  final List<String> charlieImagePaths = [
    "assets/images/Jack_Of_Clubs_greyed_out.svg",
    "assets/images/Jack_Of_Clubs.svg"
  ];

  final List<String> doppelkopfImagePaths = [
    "assets/images/4erDoppelkopf_greyed_out.svg",
    "assets/images/4erDoppelkopf.svg"
  ];
  GameOverview(this.copyGame);

  @override
  _GameOverviewState createState() => _GameOverviewState(copyGame);
}

class _GameOverviewState extends State<GameOverview> {
  Game game;

  _GameOverviewState(this.game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GameOverview"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: generateHeadingWidgetList(),
                )),
            Flexible(
              flex: 6,
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: game.getRounds().length,
                    itemBuilder: (BuildContext context, int index) {
                      return generateRoundCard(index);
                    }),
              ),
            ),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: game.playerScores.values
                        .map((score) => Text(score.toString()))
                        .toList(),
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await createAddRoundDialog(null).then((onValue) {
            if (onValue != null) {
              game.intregrateRound(onValue);
            }
          });
          setState(() {});
        },
      ),
    );
  }

  Card generateRoundCard(int index) {
    Round round = game.getRounds()[index];
    List<Widget> widgets = round
        .getPlayerIncomes()
        .values
        .map((income) => Expanded(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color:
                              income < 0 ? Colors.redAccent : Colors.lightGreen,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Center(child: Text(income.toString()))),
                    VerticalDivider(
                      color: Colors.grey[900],
                      thickness: 1.5,
                    )
                  ],
                ),
              ),
            ))
        .toList();

    widgets
        .add(Expanded(child: Center(child: Text(round.roundValue.toString()))));

    return Card(
      elevation: 8.0,
      margin: EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 22),
            onTap: () async {
              await createAddRoundDialog(round);
              setState(() {});
            },
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgets,
            )),
      ),
    );
  }

  Future<Round> createAddRoundDialog(Round round) {
    String dialogTitle;
    int roundNumber;

    if (round == null) {
      roundNumber = game.getRounds().length + 1;
      round = Round(game.players.toList());
      dialogTitle = "Create Round Nr. $roundNumber";
    } else {
      roundNumber = game.getRounds().indexOf(round) + 1;
      dialogTitle = "Change Round Nr. $roundNumber";
    }

    final PageController pageViewController = PageController(initialPage: 0);
    final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStateDialog) {
            final double customCheckboxWidth = 80;
            final double customCheckboxHeight = 85;

            return AlertDialog(
              title: Text(dialogTitle),
              content: Container(
                width: 1000000,
                height: 1000000,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageViewController,
                        onPageChanged: (int index) {
                          currentPageNotifier.value = index;
                        },
                        children: [
                          Column(mainAxisSize: MainAxisSize.min, children: [
                            Text("Ansagen Re:"),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  child: CheckboxListTile(
                                      value:
                                          round.gesprochenRe > 0 ? true : false,
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
                                      value: round.gesprochenRe == 2
                                          ? true
                                          : false,
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
                                      value: round.gesprochenContra > 0
                                          ? true
                                          : false,
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
                                      value: round.gesprochenContra == 2
                                          ? true
                                          : false,
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
                              label: generateAnnouncementsLabel(
                                  Team.contra, round),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Re"), Text("Contra")],
                            ),
                            Text("Fuchs"),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.63),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: customCheckboxWidth,
                                      height: customCheckboxHeight,
                                      child: CustomCheckbox(
                                        onTap: () {
                                          switch (extraPointsToCheckBoxValue(
                                              round,
                                              ExtraPoint.fuchs,
                                              Team.re,
                                              0)) {
                                            case 0:
                                              {
                                                round.extraPointsRe
                                                    .add(ExtraPoint.fuchs);
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
                                                round.extraPointsRe
                                                    .remove(ExtraPoint.fuchs);
                                                round.extraPointsRe.remove(
                                                    ExtraPoint.fuchsAmEnd);
                                              }
                                              break;
                                          }
                                          setStateDialog(() {});
                                        },
                                        value: extraPointsToCheckBoxValue(round,
                                            ExtraPoint.fuchs, Team.re, 0),
                                        imagePaths: widget.fuchsImagePaths,
                                      ),
                                    ),
                                    Container(
                                      width: customCheckboxWidth,
                                      height: customCheckboxHeight,
                                      child: CustomCheckbox(
                                        onTap: () {
                                          switch (extraPointsToCheckBoxValue(
                                              round,
                                              ExtraPoint.fuchs,
                                              Team.contra,
                                              0)) {
                                            case 0:
                                              {
                                                round.extraPointsContra
                                                    .add(ExtraPoint.fuchs);
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
                                                round.extraPointsContra.remove(
                                                    ExtraPoint.fuchsAmEnd);
                                              }
                                              break;
                                          }
                                          setStateDialog(() {});
                                        },
                                        value: extraPointsToCheckBoxValue(round,
                                            ExtraPoint.fuchs, Team.contra, 0),
                                        imagePaths: widget.fuchsImagePaths,
                                      ),
                                    ),
                                  ]),
                            ),
                            Text("Doppelkopf"),
                            Padding(
                              padding: const EdgeInsets.only(left: 23.63),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: customCheckboxWidth,
                                    height: customCheckboxHeight,
                                    child: CustomCheckbox(
                                      onTap: () {
                                        switch (extraPointsToCheckBoxValue(
                                            round,
                                            ExtraPoint.doppelkopf,
                                            Team.re,
                                            0)) {
                                          case 0:
                                            {
                                              round.extraPointsRe
                                                  .add(ExtraPoint.doppelkopf);
                                            }
                                            break;
                                          case 1:
                                            {
                                              round.extraPointsRe.remove(
                                                  ExtraPoint.doppelkopf);
                                            }
                                            break;
                                        }
                                        setStateDialog(() {});
                                      },
                                      value: extraPointsToCheckBoxValue(round,
                                          ExtraPoint.doppelkopf, Team.re, 0),
                                      imagePaths: widget.doppelkopfImagePaths,
                                    ),
                                  ),
                                  Container(
                                    width: customCheckboxWidth,
                                    height: customCheckboxHeight,
                                    child: CustomCheckbox(
                                      onTap: () {
                                        switch (extraPointsToCheckBoxValue(
                                            round,
                                            ExtraPoint.doppelkopf,
                                            Team.contra,
                                            0)) {
                                          case 0:
                                            {
                                              round.extraPointsContra
                                                  .add(ExtraPoint.doppelkopf);
                                            }
                                            break;
                                          case 1:
                                            {
                                              round.extraPointsContra.remove(
                                                  ExtraPoint.doppelkopf);
                                            }
                                            break;
                                        }
                                        setStateDialog(() {});
                                      },
                                      value: extraPointsToCheckBoxValue(
                                          round,
                                          ExtraPoint.doppelkopf,
                                          Team.contra,
                                          0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: customCheckboxWidth,
                                    height: customCheckboxHeight,
                                    child: CustomCheckbox(
                                      onTap: () {
                                        switch (extraPointsToCheckBoxValue(
                                            round,
                                            ExtraPoint.charlie,
                                            Team.re,
                                            0)) {
                                          case 0:
                                            {
                                              round.extraPointsRe
                                                  .add(ExtraPoint.charlie);
                                            }
                                            break;
                                          case 1:
                                            {
                                              round.extraPointsRe
                                                  .remove(ExtraPoint.charlie);
                                            }
                                            break;
                                        }
                                        setStateDialog(() {});
                                      },
                                      value: extraPointsToCheckBoxValue(round,
                                          ExtraPoint.charlie, Team.re, 0),
                                      imagePaths: widget.charlieImagePaths,
                                    ),
                                  ),
                                  Container(
                                    width: customCheckboxWidth,
                                    height: customCheckboxHeight,
                                    child: CustomCheckbox(
                                      onTap: () {
                                        switch (extraPointsToCheckBoxValue(
                                            round,
                                            ExtraPoint.charlie,
                                            Team.contra,
                                            0)) {
                                          case 0:
                                            {
                                              round.extraPointsContra
                                                  .add(ExtraPoint.charlie);
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
                                      value: extraPointsToCheckBoxValue(round,
                                          ExtraPoint.charlie, Team.contra, 0),
                                      imagePaths: widget.charlieImagePaths,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Who won?"),
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 100,
                                      child: CheckboxListTile(
                                        value: round.winningTeam == Team.re
                                            ? true
                                            : false,
                                        title: Text("Re"),
                                        onChanged: (newValue) {
                                          setStateDialog(() {
                                            if (newValue) {
                                              round.winningTeam = Team.re;
                                              while (round.winners.length > 2) {
                                                round.winners.removeLast();
                                              }
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
                                        value: round.winningTeam == Team.contra
                                            ? true
                                            : false,
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
                                                round.winningTeam == Team.draw
                                                    ? true
                                                    : false,
                                            title: Text("Draw"),
                                            onChanged: (newValue) {
                                              setStateDialog(() {
                                                if (newValue) {
                                                  round.winningTeam = Team.draw;
                                                  round.winners =
                                                      []; //bei einem Unentschieden gibt es keine Sieger
                                                } else {
                                                  round.winningTeam = null;
                                                }
                                              });
                                            }))
                                  ],
                                ),
                                Divider(),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: round.players.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        onTap: () {
                                          if (round.winners.length > 0) {
                                            //für den Fall, dass winners leer ist.
                                            if (round.winners.contains(round
                                                .players
                                                .elementAt(index))) {
                                              round.winners.remove(round.players
                                                  .elementAt(index));
                                            } else {
                                              if (round.winningTeam ==
                                                      Team.draw ||
                                                  (round.winningTeam ==
                                                          Team.re &&
                                                      round.winners.length >=
                                                          2) ||
                                                  round.winners.length ==
                                                      (game.playersPerRound -
                                                          1)) {
                                                //TODO: Invalid input feedback;

                                              } else if (round.winningTeam !=
                                                  Team.draw) {
                                                round.winners.add(round.players
                                                    .elementAt(index));
                                              }
                                            }
                                          } else {
                                            round.winners.add(
                                                round.players.elementAt(index));
                                          }
                                          setStateDialog(() {});
                                        },
                                        title: Card(
                                            color: getPlayerCardColor(round,
                                                index, game.playersPerRound),
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.0)),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(round.players
                                                      .elementAt(index)
                                                      .name),
                                                ))),
                                      );
                                    }),
                                Slider(
                                  value:
                                      round.winningTeamPoints.toDouble() / 30,
                                  label: "${round.winningTeamPoints}+",
                                  onChanged: (newValue) {
                                    round.winningTeamPoints =
                                        newValue.toInt() * 30;
                                    setStateDialog(() {});
                                  },
                                  min: 0.0,
                                  max: 8.0,
                                  divisions: 8,
                                ),
                                isRoundInputValid(round, game.playersPerRound)
                                    ? updateAndDisplayRoundValue(round)
                                    : Text("-"),
                              ]),
                        ],
                      ),
                    ),
                    CirclePageIndicator(
                      currentPageNotifier: currentPageNotifier,
                      itemCount: 2,
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: isRoundInputValid(round, game.playersPerRound)
                        ? () => submitRound(round)
                        : null,
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

  void submitRound(Round round) {
    Navigator.of(context).pop(round);
  }

  bool isRoundInputValid(Round round, int playersPerRound) {
    if (round.winningTeam == null ||
        (round.gesprochenContra == 0 &&
            round.gesprochenRe == 0 &&
            round.winningTeam != Team.draw)) {
      return false;
    } else {
      if (round.winningTeam == Team.re) {
        if (round.winners.length < 1 || round.winners.length > 2) {
          return false;
        }
      } else if (round.winningTeam == Team.contra) {
        if (round.winners.length < (playersPerRound - 2)) {
          return false;
        }
      }
    }
    if ((240 - round.announcementsContra) > round.winningTeamPoints &&
        round.winningTeam != Team.contra) {
      return false;
    } else if ((240 - round.announcementsRe) > round.winningTeamPoints &&
        round.winningTeam == Team.re) {
      return false;
    } else {
      return true;
    }
  }

  Color getPlayerCardColor(Round round, int index, int playersPerRound) {
    Player player = round.players.elementAt(index);

    if (round.winners.contains(player)) {
      return Colors.lightGreenAccent; //Sieger werden grün hinterlegt
    } else {
      switch (round.winningTeam) {
        case Team.re:
          {
            if (round.winners.length > 1) {
              return Colors
                  .redAccent; //wenn per Aussschlussverfahren klar ist, wer die Verlierer sind, werden diese Rot angezeigt
            } else {
              return Colors
                  .grey; //solange unklar ist, wer verloren hat, werden alle außer die Sieger grau angezeigt
            }
          }
          break;

        case Team.contra:
          {
            if (round.winners.length > (playersPerRound - 3)) {
              return Colors.redAccent; //wieder Ausschlussverfahren
            } else {
              return Colors.grey;
            }
          }
          break;
        case Team.draw:
          {
            return Colors.grey;
          }
          break;
        default:
          {
            return Colors.grey; //Wenn noch nichts ausgewählt wurde
          }
      }
    }
  }

  Widget updateAndDisplayRoundValue(Round round) {
    round.calculateRoundValue();

    return Text("${round.roundValue}");
  }

  List<Widget> generateHeadingWidgetList() {
    List<Widget> headers = List.empty(growable: true);

    headers = game.players
        .map((player) => Text(
              player.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ))
        .toList();
    headers.add(Text(
      "Runde",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ));
    return headers;
  }
}
