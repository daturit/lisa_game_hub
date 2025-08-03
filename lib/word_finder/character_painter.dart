import 'package:flutter/material.dart';

import '../main.dart';

class CharacterMapPainter extends CustomPainter {
   CharacterMapPainter(this.level);
   int level;
  @override

  double getFontSize(int level) {
    if (level >= 16) {
      return 16;
    } else if (level >= 13) {
      return 18;
    } else if (level >= 10) {
      return 20;
    } else if (level >= 7) {
      return 30;
    }
    return 32;
  }
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.cyan[200]!;
    // Left eye
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(10)),
        paint);
    for (int i = 0; i < gridMap.length; i++)
      for (int j = 0; j < gridMap[i].length; j++) {
        final textStyle =  TextStyle(
            color: Colors.black, fontSize: getFontSize(level), fontWeight: FontWeight.w500);
        final textSpan = TextSpan(text: gridMap[i][j], style: textStyle);
        final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
        textPainter.layout();
        final offset = Offset(j * gridSize + (gridSize - textPainter.width) / 2,
            i * gridSize + (gridSize - textPainter.height) / 2);
        textPainter.paint(canvas, offset);
      }
    //----- Found Words history
    final List<Offset> offset = [];
    final Path path = Path();
    paint.strokeWidth = gridSize;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    for (int i = 0; i < foundWords.length; i++) {
      offset.clear();
      path.reset();
      paint.color = foundColor[i];
      for (int j = 0; j < foundMap[i].length; j++) {
        offset.add(Offset(foundMap[i][j].x * gridSize + gridSize / 2,
            foundMap[i][j].y * gridSize + gridSize / 2));
      }
      path.addPolygon(offset, false);
      canvas.drawPath(path, paint);
    }

    //----- Current drawing
    final List<Offset> offsets = [];
    for (int i = 0; i < touchItems.length; i++) {
      offsets.add(Offset(touchItems[i].x * gridSize + gridSize / 2,
          touchItems[i].y * gridSize + gridSize / 2));
    }
    path.reset();
    path.addPolygon(offsets, false);
    paint.color = const Color.fromRGBO(255, 0, 0, 80);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CharacterMapPainter oldDelegate) => true;

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}