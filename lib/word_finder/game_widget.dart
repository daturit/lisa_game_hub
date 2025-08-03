import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart' hide LinearGradient;

import '../main.dart';
import 'character_painter.dart';
import 'database_helper.dart';
import 'helper.dart';

// finish save data base complete
class GameWidget extends StatefulWidget {
  final String category;
  final List<AWord> words;
  final int numberCol;
  final int numberPuzzle;

  GameWidget({
    required this.category,
    required this.words,
    required this.numberCol,
    required this.numberPuzzle,
  });

  @override
  _GameWidgetState createState() => _GameWidgetState();
}

const int maxFailedLoadAttempts = 3;

class _GameWidgetState extends State<GameWidget> {
  late int gridW;
  late int gridH;
  List<String> wordsList = [];

  late Size panSize;

  double x = 0.0;
  double y = 0.0;
  int timeElapsed = 10;

  final GlobalKey _keyRed = GlobalKey();
  late bool validTouchFlag = false;

  static const duration = Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  late Timer timer = Timer.periodic(duration, (Timer t) {
    handleTick();
  });

  void handleTick() {
    setState(() {
      secondsPassed = secondsPassed + 1;
    });
  }

  void showDialogBack() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GiffyDialog.lottie(
          Lottie.asset(
            "assets/images/A.json",
            height: 200,
            fit: BoxFit.contain,
          ),
          title: const Text('DO YOU WANT EXIT?', textAlign: TextAlign.center),
          content: const Text('', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showDialogFinish(BuildContext mainContext) {
    print("le anh tuan finish! ${widget.numberPuzzle.toString()}");
    // save finish to data local
    Helper.saveData(ModelUnlock(key: widget.numberPuzzle.toString(), value: 1));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GiffyDialog.lottie(
          Lottie.asset(
            "assets/images/A.json",
            height: 200,
            fit: BoxFit.contain,
          ),
          title: const Text('Congratulations!', textAlign: TextAlign.center),
          content: Text(
            "You Finish Puzzle ${widget.numberPuzzle}",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(mainContext);
                Navigator.pop(context, 'OK');
                //Next level
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void finishGame() {
    timer.cancel();
    showDialogFinish(context);
  }

  void _incrementDown(PointerEvent details) {
    _updateLocation(details);
    //    finishGame();
    setState(() {
      touchItems.clear();
      validTouchFlag = true;
    });
  }

  void _incrementUp(PointerEvent details) {
    _updateLocation(details);
    String selectedStr = "";
    touchItems.forEach((element) {
      selectedStr = selectedStr + gridMap[element.y.toInt()][element.x.toInt()];
    });
    if (wordsList.contains(selectedStr) && !foundWords.contains(selectedStr)) {
      foundMap.add(
        List<Point>.generate(touchItems.length, (index) => touchItems[index]),
      );
      foundColor.add(
        Color.fromARGB(
          100,
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
        ),
      );
      foundWords.add(selectedStr);

      if (foundWords.length == wordsList.length) {
        finishGame();
      }
    }
    touchItems.clear();
  }

  void _updateLocation(PointerEvent details) {
    if (validTouchFlag == true) {
      setState(() {
        x = details.position.dx - _getPositions().dx;
        y = details.position.dy - _getPositions().dy;

        int itemX = x ~/ gridSize;
        int itemY = y ~/ gridSize;
        if (!touchItems.contains(Point(itemX, itemY)) &&
            itemX >= 0 &&
            itemX < gridW &&
            itemY >= 0 &&
            itemY < gridH) {
          Offset itemPos = Offset(
            itemX * gridSize + gridSize / 2,
            itemY * gridSize + gridSize / 2,
          );
          Offset touchPos = Offset(x, y);
          if ((itemPos - touchPos).distance < gridSize / 2.5)
            if (touchItems.length < 2) {
              touchItems.add(Point(itemX, itemY));
            } else {
              if (itemX + touchItems[touchItems.length - 2].x ==
                      touchItems[touchItems.length - 1].x * 2 &&
                  itemY + touchItems[touchItems.length - 2].y ==
                      touchItems[touchItems.length - 1].y * 2) {
                touchItems.add(Point(itemX, itemY));
              }
            }
        }
      });
    }
  }

  Offset _getPositions() {
    final RenderBox renderBox =
        _keyRed.currentContext!.findRenderObject()! as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  @override
  void initState() {
    super.initState();
    foundMap.clear();
    foundColor.clear();
    foundWords.clear();
    touchItems.clear();
    _initializeGame();
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFa1c4fd), // Light blue
                  Color(0xFFc2e9fb), // Soft blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const SizedBox(height: 1),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      // Container(
                      //     height: 50,
                      //     width: 50,
                      //     child: const Icon(Icons.settings,
                      //         color: Colors.white, size: 40))
                    ],
                  ),
                ),
                if (isTime) _buildTimeWidget(minutes, seconds),
                _buildResult(),
                _buildGenerateMatrix(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white70, width: 3),
        boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 5)],
        color: Colors.white70.withOpacity(0.9),
      ),
      child: Column(
        children: [
          Container(
            width: deviceWidth * 0.9,
            height: (wordsList.length * 13).toDouble() + 30,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(0),
              crossAxisCount: 3,
              childAspectRatio: 4,
              children: wordsList
                  .map(
                    (data) => Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 5,
                      ),
                      child: Center(
                        child: Text(
                          data,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: foundWords.contains(data)
                                ? foundColor[foundWords.indexOf(data)]
                                : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenerateMatrix() {
    return Align(
      alignment: Alignment.topCenter,
      child: Listener(
        onPointerDown: _incrementDown,
        onPointerMove: _updateLocation,
        onPointerUp: _incrementUp,
        child: Column(
          children: <Widget>[
            Container(
              width: panSize.width,
              height: panSize.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 5),
                ],
                color: Colors.cyan[200]?.withOpacity(0.5),
              ),
              //color: Colors.white,
              child: CustomPaint(
                painter: CharacterMapPainter(widget.numberCol),
                key: _keyRed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeWidget(int minutes, int seconds) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.cyan[200]?.withOpacity(0.4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Time',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Text(
              //'$timeElapsed',
              "$minutes:$seconds",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildBestTimeWidget() {
  //   return Container(
  //       margin: const EdgeInsets.symmetric(horizontal: 5),
  //       padding: const EdgeInsets.all(5),
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10), color: Colors.cyan[800]),
  //       child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
  //         const Text('Best Time',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.bold)),
  //         Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 5),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.yellow[700]),
  //             child: Text(widget.bestTime,
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold))),
  //       ]));
  // }

  void _initializeGame() {
    gridH = widget.numberCol;
    gridW = widget.numberCol;
    gridSize = (deviceWidth - 20) / gridW;

    gridMap = List<List<String>>.generate(
      gridH,
      (i) => List<String>.generate(gridW, (j) => ""),
    );
    panSize = Size(gridW.toDouble() * gridSize, gridH.toDouble() * gridSize);
    wordsList = List<String>.generate(
      widget.words.length,
      (index) => widget.words[index].word.toUpperCase(),
    );
    wordsList.sort((b, a) => a.length.compareTo(b.length));
    var random = new Random();
    if (wordsList.length == 0) return;
    var first = generate(random.nextInt(8), wordsList[0]);
    Point pt = Point(
      random.nextInt(gridW - first.first.length + 1),
      random.nextInt(gridH - first.length + 1),
    );
    putOnGrid(first, pt);
    for (int wi = 1; wi < wordsList.length; wi++) {
      int dir;
      checkFound:
      for (dir = 0; dir < 8; dir++) {
        //find if words match exist
        var piece = generate(dir, wordsList[wi]);
        for (int i = 0; i < gridH - piece.length; i++)
          for (int j = 0; j < gridW - piece.first.length; j++) {
            int matchCharCount = 0, dismatchCharCount = 0;
            for (int ii = 0; ii < piece.length; ii++)
              for (int jj = 0; jj < piece.first.length; jj++) {
                if (piece[ii][jj] == gridMap[i + ii][j + jj] &&
                    piece[ii][jj] != "") {
                  matchCharCount++;
                } else if (piece[ii][jj] != gridMap[i + ii][j + jj] &&
                    gridMap[i + ii][j + jj] != "") {
                  dismatchCharCount++;
                }
              }
            if (matchCharCount > 0 && dismatchCharCount == 0) {
              putOnGrid(piece, Point(j, i));
              break checkFound;
            }
          }
      }
      if (dir == 8) {
        putAsAnother:
        while (true) {
          var piece = generate(random.nextInt(8), wordsList[wi]);
          int i = random.nextInt(gridH - piece.length);
          int j = random.nextInt(gridW - piece.first.length);
          int matchCharCount = 0;
          for (int ii = 0; ii < piece.length; ii++)
            for (int jj = 0; jj < piece.first.length; jj++) {
              if (gridMap[i + ii][j + jj] != "") matchCharCount++;
            }
          if (matchCharCount == 0) {
            putOnGrid(piece, Point(j, i));
            break putAsAnother;
          }
        }
      }
    }

    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (int i = 0; i < gridMap.length; i++)
      for (int j = 0; j < gridMap[i].length; j++) {
        if (gridMap[i][j] == "") gridMap[i][j] = chars[random.nextInt(26)];
      }
  }

  void putOnGrid(List<List<String>> piece, Point pt) {
    for (int i = 0; i < piece.length; i++)
      for (int j = 0; j < piece[i].length; j++) {
        gridMap[pt.y.toInt() + i][pt.x.toInt() + j] = piece[i][j];
      }
  }

  List<List<String>> generate(int direction, String aword) {
    List<List<String>> grid = [];
    if (direction == 0) {
      grid = List<List<String>>.generate(
        1,
        (i) => List<String>.generate(aword.length, (j) => aword[j]),
      );
    } else if (direction == 1) {
      grid = List<List<String>>.generate(
        aword.length,
        (i) =>
            List<String>.generate(aword.length, (j) => i == j ? aword[i] : ""),
      );
    } else if (direction == 2) {
      grid = List<List<String>>.generate(
        aword.length,
        (i) => List<String>.generate(1, (j) => aword[i]),
      );
    } else if (direction == 3) {
      grid = List<List<String>>.generate(
        aword.length,
        (i) => List<String>.generate(
          aword.length,
          (j) => i + j + 1 == aword.length ? aword[i] : "",
        ),
      );
    } else if (direction == 4) {
      grid = List<List<String>>.generate(
        1,
        (i) => List<String>.generate(
          aword.length,
          (j) => aword[aword.length - 1 - j],
        ),
      );
    } else if (direction == 5) {
      grid = List<List<String>>.generate(
        aword.length,
        (i) => List<String>.generate(
          aword.length,
          (j) => i == j ? aword[aword.length - i - 1] : "",
        ),
      );
    } else if (direction == 6) {
      grid = List<List<String>>.generate(
        aword.length,
        (i) => List<String>.generate(1, (j) => aword[aword.length - i - 1]),
      );
    } else if (direction == 7) {
      grid = List<List<String>>.generate(
        aword.length,
        (i) => List<String>.generate(
          aword.length,
          (j) => i + j + 1 == aword.length ? aword[j] : "",
        ),
      );
    }
    return grid;
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }
}
