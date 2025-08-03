import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lisa_game_hub/2048_game/game_2048_screen.dart';
import 'package:lisa_game_hub/piano_music/core_tiles/app_data.dart';
import 'package:lisa_game_hub/piano_music/utils_game/piano_game_page.dart';
import 'package:lisa_game_hub/word_finder/data_helper.dart';
import 'package:lisa_game_hub/word_finder/database_helper.dart';
import 'package:lisa_game_hub/word_finder/game_widget.dart';
import 'package:lisa_game_hub/word_finder/main_page_intro.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<List<AWord>> allWords = [];
  final numberCol = 12;
  Random random = Random();

  @override
  void initState() {
    _initializeDatabase(numberCol, listCategoryDaily);
    super.initState();
  }

  Future _initializeDatabase(int level, List<List<String>> listPuzzle) async {
    final List<ACategory> list = [];
    final List<List<String>> listCategoryTemp = listPuzzle;
    final List<String> catsTemp = cats;

    for (int i = 0; i < listCategoryTemp.length; i++) {
      list.add(ACategory(catsTemp[i]));
    }
    for (int i = 0; i < listCategoryTemp.length; i++) {
      final List<AWord> listWord = [];
      for (int j = 0; j < listCategoryTemp[i].length; j++) {
        listWord.add(AWord(catsTemp[i], listCategoryTemp[i][j].toString()));
      }
      allWords.add(listWord);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tools = [
      {"icon": Icons.edit, "label": "Sign", "type": "sign"},
      {"icon": Icons.merge, "label": "Merge to PDF", "type": "merge"},
      {"icon": Icons.edit_note, "label": "Edit PDF", "type": "edit"},
      {"icon": Icons.view_compact_alt, "label": "View PDF", "type": "view"},
    ];

    final List<Map<String, dynamic>> toolsConvert = [
      {"icon": Icons.image, "label": "PDF to Image", "type": "pdftoimage"},
      {"icon": Icons.device_hub, "label": "Slip PDF", "type": "slip"},
      {"icon": Icons.image, "label": "PDF to Image", "type": "pdftoimage"},
      {"icon": Icons.device_hub, "label": "Slip PDF", "type": "slip"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Games Offline',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Puzzle Games',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildGrid(tools),

              const SizedBox(height: 28),
              const Text(
                'Music Games',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildGrid(toolsConvert),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Map<String, dynamic>> tools) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tools.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return _buildToolItem(
          context,
          tools[index]['label'],
          tools[index]['icon'],
          tools[index]['type'],
        );
      },
    );
  }

  Widget _buildToolItem(
    BuildContext context,
    String label,
    IconData iconData,
    String type,
  ) {
    return GestureDetector(
      onTap: () {
        if (type == 'merge') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PianoGamePage(AppData.mainMusic),
            ),
          );
        } else if (type == "sign") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Game2048Screen()),
          );
        } else {
          _navigateToGamePage(context, 0);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(iconData, size: 36, color: Colors.blueAccent),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'PDF',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGamePage(BuildContext context, int index) async {
    final int randomValue = random.nextInt(listCategoryDaily.length - 1);
    print("value random $randomValue");
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPageIntro()),
    );
    setState(() {});
  }
}
