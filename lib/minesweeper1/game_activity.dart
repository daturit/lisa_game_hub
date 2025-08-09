import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lisa_game_hub/minesweeper1/board_square.dart';

enum ImageType {
  zero, one, two, three, four, five, six, seven, eight,
  bomb, facingDown, flagged,
}

class GameActivity extends StatefulWidget {
  @override
  State<GameActivity> createState() => _GameActivityState();
}

class _GameActivityState extends State<GameActivity> {
  static const int rowCount = 18;
  static const int columnCount = 10;
  static const int bombProbability = 3;
  static const int maxProbability = 15;

  late List<List<BoardSquare>> board;
  late List<bool> openedSquares;
  late List<bool> flaggedSquares;

  int bombCount = 0;
  late int squaresLeft;

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mines weeper',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: [
          _buildTopBar(),
          _buildBoard(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      color: Colors.grey,
      height: 60,
      child: Center(
        child: InkWell(
          onTap: _initialiseGame,
          child: const CircleAvatar(
            backgroundColor: Colors.yellowAccent,
            child: Icon(Icons.tag_faces, color: Colors.black, size: 40),
          ),
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
      ),
      itemCount: rowCount * columnCount,
      itemBuilder: (context, position) {
        final row = position ~/ columnCount;
        final col = position % columnCount;
        final image = _getSquareImage(row, col, position);

        return InkWell(
          splashColor: Colors.grey,
          onTap: () => _onSquareTap(row, col, position),
          onLongPress: () => _onSquareLongPress(position),
          child: Container(color: Colors.grey, child: image),
        );
      },
    );
  }

  Image _getSquareImage(int row, int col, int pos) {
    if (!openedSquares[pos]) {
      return flaggedSquares[pos]
          ? _getImage(ImageType.flagged)
          : _getImage(ImageType.facingDown);
    }
    return board[row][col].hasBomb
        ? _getImage(ImageType.bomb)
        : _getImage(_getImageTypeFromNumber(board[row][col].bombsAround));
  }

  void _onSquareTap(int row, int col, int pos) {
    if (board[row][col].hasBomb) {
      _handleGameOver();
      return;
    }

    if (board[row][col].bombsAround == 0) {
      _openAdjacent(row, col);
    } else {
      setState(() {
        openedSquares[pos] = true;
        squaresLeft--;
      });
    }

    if (squaresLeft <= bombCount) {
      _handleWin();
    }
  }

  void _onSquareLongPress(int pos) {
    if (!openedSquares[pos]) {
      setState(() {
        flaggedSquares[pos] = !flaggedSquares[pos];
      });
    }
  }

  void _initialiseGame() {
    board = List.generate(rowCount, (_) => List.generate(columnCount, (_) => BoardSquare()));
    openedSquares = List.filled(rowCount * columnCount, false);
    flaggedSquares = List.filled(rowCount * columnCount, false);

    bombCount = 0;
    squaresLeft = rowCount * columnCount;

    final random = Random();
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (random.nextInt(maxProbability) < bombProbability) {
          board[i][j].hasBomb = true;
          bombCount++;
        }
      }
    }
    _calculateBombsAround();
    setState(() {});
  }

  void _calculateBombsAround() {
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (!board[i][j].hasBomb) {
          int count = 0;
          for (int x = -1; x <= 1; x++) {
            for (int y = -1; y <= 1; y++) {
              if (x == 0 && y == 0) continue;
              final nx = i + x, ny = j + y;
              if (nx >= 0 && nx < rowCount && ny >= 0 && ny < columnCount && board[nx][ny].hasBomb) {
                count++;
              }
            }
          }
          board[i][j].bombsAround = count;
        }
      }
    }
  }

  void _openAdjacent(int i, int j) {
    final pos = i * columnCount + j;
    if (openedSquares[pos]) return;

    openedSquares[pos] = true;
    squaresLeft--;

    if (board[i][j].bombsAround > 0) return;

    for (int x = -1; x <= 1; x++) {
      for (int y = -1; y <= 1; y++) {
        if (x == 0 && y == 0) continue;
        final nx = i + x, ny = j + y;
        if (nx >= 0 && nx < rowCount && ny >= 0 && ny < columnCount) {
          _openAdjacent(nx, ny);
        }
      }
    }
    setState(() {});
  }

  void _handleGameOver() {
    _showDialog("Game Over!", "You stepped on a mine!");
  }

  void _handleWin() {
    _showDialog("Congratulations!", "You Win!");
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _initialiseGame();
            },
            child: const Text("Play again"),
          ),
        ],
      ),
    );
  }

  Image _getImage(ImageType type) {
    return Image.asset('assets/images/${_imageName(type)}.png');
  }

  String _imageName(ImageType type) {
    switch (type) {
      case ImageType.zero: return '0';
      case ImageType.one: return '1';
      case ImageType.two: return '2';
      case ImageType.three: return '3';
      case ImageType.four: return '4';
      case ImageType.five: return '5';
      case ImageType.six: return '6';
      case ImageType.seven: return '7';
      case ImageType.eight: return '8';
      case ImageType.bomb: return 'bomb';
      case ImageType.facingDown: return 'facingDown';
      case ImageType.flagged: return 'flagged';
    }
  }

  ImageType _getImageTypeFromNumber(int number) {
    return ImageType.values[number];
  }
}
