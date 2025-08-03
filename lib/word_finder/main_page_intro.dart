import 'dart:math';

import 'package:flutter/material.dart';
import '../main.dart';
import 'data_helper.dart';
import 'database_helper.dart';
import 'game_widget.dart';
import 'pack_page.dart';

class MainPageIntro extends StatefulWidget {
  const MainPageIntro({Key? key}) : super(key: key);

  @override
  State<MainPageIntro> createState() => _MainPageIntroState();
}

class _MainPageIntroState extends State<MainPageIntro> {
  List<List<AWord>> allWords = [];
  final numberCol = 12;

  Random random = Random();

  @override
  void initState() {
    _initializeDatabase(numberCol, listCategoryDaily);
    _getSetting();
    super.initState();
  }

  void _getSetting() async {}

  void _goToCategoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PackPage()),
    );
  }

  void _navigateToGamePage(BuildContext context, int index) async {
    // random data for daily
    final int randomValue = random.nextInt(listCategoryDaily.length - 1);
    print("value random $randomValue");
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameWidget(
          category: "",
          words: allWords[randomValue],
          numberCol: numberCol,
          numberPuzzle: 100,
        ),
      ),
    );
    setState(() {});
  }

  void getHeightWidth(context) {
    deviceWidth = MediaQuery.of(context).size.width;
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
    getHeightWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Word Finder',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF89F7FE), // Màu bắt đầu (xanh nhạt)
                  Color(0xFF66A6FF), // Màu kết thúc (xanh đậm hơn)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              Container(
                alignment: Alignment.center,
                height: 200,
                child: const Text(
                  "Word Finder",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _goToCategoryPage,
                child: Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.green,
                  ),
                  child: const Text(
                    "PUZZLE",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  _navigateToGamePage(context, 0);
                },
                child: _buildButton("DAILY", Colors.orange),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String name, Color color) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: color,
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
