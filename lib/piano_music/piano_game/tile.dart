import 'package:flutter/material.dart';
import '../core_tiles/app_data.dart';
import 'note.dart';

class Tile extends StatelessWidget {
  final NoteState state;
  final double height;
  final int indexTheme;
  final VoidCallback onTap;

  const Tile(
      {Key? key,
      required this.height,
      required this.indexTheme,
      required this.state,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: GestureDetector(
        onTapDown: (_) => onTap(),
        child: Container(
            color: color,
            child: Image.asset(
                "assets/image2048/${AppData.tilesList[indexTheme % AppData.tilesList.length]}")
            // child: Icon(
            //     indexTheme % 2 == 0 ? Icons.local_activity : Icons.ac_unit,
            //     color: Colors.white),
            ),
      ),
    );
  }

  Color get color {
    switch (state) {
      case NoteState.ready:
        return Colors.black;
      case NoteState.missed:
        return Colors.white;
      // case NoteState.tapped:
      //   return Colors.transparent;
      case NoteState.tapped:
        return Colors.black12.withOpacity(0.2);
      default:
        return Colors.black;
    }
  }
}
