import 'package:flutter/material.dart';

import 'note.dart';
import 'tile.dart';

class Line extends AnimatedWidget {
  final int lineNumber;
  final int indexTheme;
  final List<Note> currentNotes;
  final Function(Note) onTileTap;

  const Line(
      {Key? key,
      required this.currentNotes,
      required this.lineNumber,
      required this.indexTheme,
      required this.onTileTap,
      required Animation<double> animation})
      : super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    //get heights
    double height = MediaQuery.of(context).size.height;
    double tileHeight = height / 4;

    //get only notes for that line
    List<Note> thisLineNotes =
        currentNotes.where((note) => note.line == lineNumber).toList();

    //map notes to widgets
    List<Widget> tiles = thisLineNotes.map((note) {
      //specify note distance from top
      int index = currentNotes.indexOf(note);
      double offset = (3 - index + animation.value) * tileHeight;

      return Transform.translate(
        offset: Offset(0, offset),
        child: Tile(
          indexTheme: indexTheme,
          height: tileHeight,
          state: note.state,
          onTap: () => onTileTap(note),
        ),
      );
    }).toList();

    return SizedBox.expand(
      child: Stack(
        children: tiles,
      ),
    );
  }
}
