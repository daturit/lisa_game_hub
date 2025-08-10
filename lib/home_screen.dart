import 'dart:math';
import 'package:flutter/material.dart';

import 'package:lisa_game_hub/2048_game/game_2048_screen.dart';
import 'package:lisa_game_hub/minesweeper1/game_activity.dart';
import 'package:lisa_game_hub/piano_music/core_tiles/app_data.dart';
import 'package:lisa_game_hub/piano_music/utils_game/piano_game_page.dart';
import 'package:lisa_game_hub/sudoku/sudoku_game_screen.dart';
import 'package:lisa_game_hub/tic_tac_toe/views/login_screen.dart';
import 'package:lisa_game_hub/word_finder/data_helper.dart';
import 'package:lisa_game_hub/word_finder/database_helper.dart';
import 'package:lisa_game_hub/word_finder/main_page_intro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<AWord>> allWords = [];
  final numberCol = 12;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _initializeDatabase(numberCol, listCategoryDaily);
  }

  Future<void> _initializeDatabase(int level, List<List<String>> listPuzzle) async {
    final List<String> catsTemp = cats;

    for (int i = 0; i < listPuzzle.length; i++) {
      final words = listPuzzle[i]
          .map((word) => AWord(catsTemp[i], word.toString()))
          .toList();
      allWords.add(words);
    }
  }

  // Danh sách game
  final List<Map<String, dynamic>> puzzleGames = [];
  final List<Map<String, dynamic>> casualGames = [];

  @override
  Widget build(BuildContext context) {
    final puzzleGames = [
      {
        "icon": Icons.edit,
        "label": "2048",
        "onTap": () => _goTo(context, const Game2048Screen()),
      },
      {
        "icon": Icons.merge,
        "label": "Minesweeper",
        "onTap": () => _goTo(context, GameActivity()),
      },
      {
        "icon": Icons.edit_note,
        "label": "Sudoku",
        "onTap": () => _goTo(context, const SudokuGame()),
      },
      {
        "icon": Icons.view_compact_alt,
        "label": "Word Finder",
        "onTap": () => _goTo(context, const MainPageIntro()),
      },
    ];

    final casualGames = [
      {
        "icon": Icons.image,
        "label": "Tic tac toe (1P)",
        "onTap": () => _goTo(context, const LoginScreen(isSingleMode: true)),
      },
      {
        "icon": Icons.device_hub,
        "label": "Piano Music",
        "onTap": () => _goTo(context, PianoGamePage(AppData.mainMusic)),
      },
      {
        "icon": Icons.image,
        "label": "Tic tac toe (2P)",
        "onTap": () => _goTo(context, const LoginScreen(isSingleMode: false)),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Games Offline',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Puzzle Games"),
              _buildGrid(puzzleGames),
              const SizedBox(height: 28),
              _buildSectionTitle("Casual Games"),
              _buildGrid(casualGames),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> games) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: games.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final game = games[index];
        return _buildGameCard(game["label"], game["icon"], game["onTap"]);
      },
    );
  }

  Widget _buildGameCard(String label, IconData iconData, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 36, color: Colors.blueAccent),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  void _goTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
