import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckbox extends StatefulWidget {
  //gibt als Child ein Bild aus einer Üübergebenen Bilder-List, je nach Saktuellem Status(value)
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();

  CustomCheckbox(
      {@required this.onTap,
      @required this.value,
      @required this.imagePaths,
      this.alignment});

  final Alignment alignment;  //nur zum übergeben an die State Klasse
  final List<String> imagePaths;
  final Function onTap;
  int value; // speichert den aktuellen Status:
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  Alignment alignment;
  @override
  initState() {
    if (widget.alignment == null) {
      alignment = Alignment.centerLeft;
    } else {
      alignment = widget.alignment;
    }

    if (widget.value < 0 || widget.value == null) {
      print(
          "Error: ungültiger Value-Wert an CustomCheckbox übergeben"); //TODO: Throw Error
    }
    if (widget.imagePaths == null) {
      print("Error: Keine Bilddaten übergeben");
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
            width: 120,
            height: 85,
            child: SvgPicture.asset(
              getImageString(),
              alignment: alignment,
            )));
  }

  String getImageString() {
    // return normales oder ausgegrautes Bild
    return widget.imagePaths[widget.value];
  }
}
