import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

import 'board_style.dart';
import 'styles.dart';

class SudokuGame extends StatefulWidget {
  const SudokuGame({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SudokuGameState();
}

class SudokuGameState extends State<SudokuGame> {
  bool firstRun = true;
  bool gameOver = false;
  int timesCalled = 0;
  bool isButtonDisabled = false;
  bool isFABDisabled = false;
  late List<List<List<int>>> gameList;
  late List<List<int>> game;
  late List<List<int>> gameCopy;
  late List<List<int>> gameSolved;
  static String? currentDifficultyLevel;
  static String? currentTheme;
  static String? currentAccentColor;
  static String platform = () {
    if (kIsWeb) {
      return 'web-${defaultTargetPlatform.toString().replaceFirst("TargetPlatform.", "").toLowerCase()}';
    } else {
      return defaultTargetPlatform
          .toString()
          .replaceFirst("TargetPlatform.", "")
          .toLowerCase();
    }
  }();
  static bool isDesktop = ['windows', 'linux', 'macos'].contains(platform);

  @override
  void initState() {
    super.initState();
    getPrefs().whenComplete(() {
      if (currentDifficultyLevel == null) {
        currentDifficultyLevel = 'easy';
        setPrefs('currentDifficultyLevel');
      }
      if (currentTheme == null) {
        if (MediaQuery.maybeOf(context)?.platformBrightness != null) {
          currentTheme =
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? 'light'
              : 'dark';
        } else {
          currentTheme = 'dark';
        }
        setPrefs('currentTheme');
      }
      if (currentAccentColor == null) {
        currentAccentColor = 'Blue';
        setPrefs('currentAccentColor');
      }
      newGame(currentDifficultyLevel!);
      changeTheme('set');
      changeAccentColor(currentAccentColor!, true);
    });
  }

  Future<void> getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentDifficultyLevel = prefs.getString('currentDifficultyLevel');
      currentTheme = prefs.getString('currentTheme');
      currentAccentColor = prefs.getString('currentAccentColor');
    });
  }

  setPrefs(String property) async {
    final prefs = await SharedPreferences.getInstance();
    if (property == 'currentDifficultyLevel') {
      prefs.setString('currentDifficultyLevel', currentDifficultyLevel!);
    } else if (property == 'currentTheme') {
      prefs.setString('currentTheme', currentTheme!);
    } else if (property == 'currentAccentColor') {
      prefs.setString('currentAccentColor', currentAccentColor!);
    }
  }

  void changeTheme(String mode) {
    setState(() {
      if (currentTheme == 'light') {
        if (mode == 'switch') {
          Styles.primaryBackgroundColor = Styles.darkGrey;
          Styles.secondaryBackgroundColor = Styles.grey;
          Styles.foregroundColor = Styles.white;
          currentTheme = 'dark';
        } else if (mode == 'set') {
          Styles.primaryBackgroundColor = Styles.white;
          Styles.secondaryBackgroundColor = Styles.white;
          Styles.foregroundColor = Styles.darkGrey;
        }
      } else if (currentTheme == 'dark') {
        if (mode == 'switch') {
          Styles.primaryBackgroundColor = Styles.white;
          Styles.secondaryBackgroundColor = Styles.white;
          Styles.foregroundColor = Styles.darkGrey;
          currentTheme = 'light';
        } else if (mode == 'set') {
          Styles.primaryBackgroundColor = Styles.darkGrey;
          Styles.secondaryBackgroundColor = Styles.grey;
          Styles.foregroundColor = Styles.white;
        }
      }
      setPrefs('currentTheme');
    });
  }

  void changeAccentColor(String color, [bool firstRun = false]) {
    setState(() {
      if (Styles.accentColors.keys.contains(color)) {
        Styles.primaryColor = Styles.accentColors[color]!;
      } else {
        currentAccentColor = 'Blue';
        Styles.primaryColor = Styles.accentColors[color]!;
      }
      if (color == 'Red') {
        Styles.secondaryColor = Styles.orange;
      } else {
        Styles.secondaryColor = Styles.lightRed;
      }
      if (!firstRun) {
        setPrefs('currentAccentColor');
      }
    });
  }

  void checkResult() {
    try {
      if (SudokuUtilities.isSolved(game)) {
        isButtonDisabled = !isButtonDisabled;
        gameOver = true;
        Timer(const Duration(milliseconds: 500), () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (_) => AlertDialog(
              title: const Text('Game Over'),
              content: const Text('Congratulations! You solved the puzzle.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    newGame();
                  },
                  child: const Text('New Game'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    restartGame();
                  },
                  child: const Text('Restart'),
                ),
              ],
            ),
          );
        });
      }
    } on InvalidSudokuConfigurationException {
      return;
    }
  }

  static Future<List<List<List<int>>>> getNewGame([
    String difficulty = 'easy',
  ]) async {
    int emptySquares;
    switch (difficulty) {
      case 'test':
        emptySquares = 2;
        break;
      case 'beginner':
        emptySquares = 18;
        break;
      case 'easy':
        emptySquares = 27;
        break;
      case 'medium':
        emptySquares = 36;
        break;
      case 'hard':
        emptySquares = 54;
        break;
      default:
        emptySquares = 2;
        break;
    }
    SudokuGenerator generator = SudokuGenerator(emptySquares: emptySquares);
    return [generator.newSudoku, generator.newSudokuSolved];
  }

  static List<List<int>> copyGrid(List<List<int>> grid) {
    return grid.map((row) => [...row]).toList();
  }

  void setGame(int mode, [String difficulty = 'easy']) async {
    if (mode == 1) {
      game = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameCopy = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      gameSolved = List.filled(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
    } else {
      gameList = await getNewGame(difficulty);
      game = gameList[0];
      gameCopy = copyGrid(game);
      gameSolved = gameList[1];
    }
  }

  void showSolution() {
    setState(() {
      game = copyGrid(gameSolved);
      isButtonDisabled = true;
      gameOver = true;
    });
  }

  void newGame([String difficulty = 'easy']) {
    setState(() {
      isFABDisabled = !isFABDisabled;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        setGame(2, difficulty);
        isButtonDisabled = false;
        gameOver = false;
        isFABDisabled = !isFABDisabled;
      });
    });
  }

  void restartGame() {
    setState(() {
      game = copyGrid(gameCopy);
      isButtonDisabled = false;
      gameOver = false;
    });
  }

  List<SizedBox> createButtons() {
    if (firstRun) {
      setGame(1);
      firstRun = false;
    }

    List<SizedBox> buttonList = List<SizedBox>.filled(9, const SizedBox());
    for (var i = 0; i <= 8; i++) {
      var k = timesCalled;
      buttonList[i] = SizedBox(
        key: Key('grid-button-$k-$i'),
        width: buttonSize(),
        height: buttonSize(),
        child: TextButton(
          onPressed: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () {
            showDialog<void>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Enter Number'),
                content: Wrap(
                  children: List.generate(9, (num) {
                    return TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        callback([k, i], num + 1);
                      },
                      child: Text('${num + 1}'),
                    );
                  }),
                ),
              ),
            );
          },
          onLongPress: isButtonDisabled || gameCopy[k][i] != 0
              ? null
              : () => callback([k, i], 0),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              buttonColor(k, i),
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return gameCopy[k][i] == 0
                      ? emptyColor(gameOver)
                      : Styles.foregroundColor;
                }
                return game[k][i] == 0
                    ? buttonColor(k, i)
                    : Styles.secondaryColor;
              },
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: buttonEdgeRadius(k, i)),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: Styles.foregroundColor,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: Text(
            game[k][i] != 0 ? game[k][i].toString() : ' ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: buttonFontSize()),
          ),
        ),
      );
    }
    timesCalled++;
    if (timesCalled == 9) {
      timesCalled = 0;
    }
    return buttonList;
  }

  Row oneRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: createButtons(),
  );

  List<Row> createRows() =>
      List<Row>.generate(9, (i) => oneRow());

  void callback(List<int> index, int? number) {
    setState(() {
      if (number == null) return;
      game[index[0]][index[1]] = number;
      if (number != 0) checkResult();
    });
  }

  showOptionModalSheet(BuildContext context) {
    BuildContext outerContext = context;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Styles.secondaryBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        final TextStyle customStyle = TextStyle(
          inherit: false,
          color: Styles.foregroundColor,
        );
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.refresh, color: Styles.foregroundColor),
              title: Text('Restart Game', style: customStyle),
              onTap: () {
                Navigator.pop(context);
                Timer(const Duration(milliseconds: 200), () => restartGame());
              },
            ),
            ListTile(
              leading: Icon(Icons.add_rounded, color: Styles.foregroundColor),
              title: Text('New Game', style: customStyle),
              onTap: () {
                Navigator.pop(context);
                Timer(
                  const Duration(milliseconds: 200),
                      () => newGame(currentDifficultyLevel!),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline_rounded,
                  color: Styles.foregroundColor),
              title: Text('Show Solution', style: customStyle),
              onTap: () {
                Navigator.pop(context);
                Timer(
                    const Duration(milliseconds: 200), () => showSolution());
              },
            ),
            ListTile(
              leading: Icon(Icons.build_outlined,
                  color: Styles.foregroundColor),
              title: Text('Set Difficulty', style: customStyle),
              onTap: () {
                Navigator.pop(context);
                Timer(
                  const Duration(milliseconds: 300),
                      () => showDialog<void>(
                    context: outerContext,
                    builder: (_) => AlertDialog(
                      title: const Text('Set Difficulty'),
                      content: const Text('Feature not implemented'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(outerContext),
                          child: const Text('Close'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.invert_colors_on_rounded,
                  color: Styles.foregroundColor),
              title: Text('Switch Theme', style: customStyle),
              onTap: () {
                Navigator.pop(context);
                Timer(const Duration(milliseconds: 200),
                        () => changeTheme('switch'));
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens_outlined,
                  color: Styles.foregroundColor),
              title: Text('Change Accent Color', style: customStyle),
              onTap: () {
                Navigator.pop(context);
                Timer(
                  const Duration(milliseconds: 200),
                      () => showDialog<void>(
                    context: outerContext,
                    builder: (_) => AlertDialog(
                      title: const Text('Change Accent Color'),
                      content: const Text('Feature not implemented'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(outerContext),
                          child: const Text('Close'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryBackgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          title: const Text(
            'Sudoku',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: createRows(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Styles.primaryBackgroundColor,
        backgroundColor: isFABDisabled
            ? Styles.primaryColor[900]
            : Styles.primaryColor,
        onPressed:
        isFABDisabled ? null : () => showOptionModalSheet(context),
        child: const Icon(Icons.menu_rounded),
      ),
    );
  }
}
