import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lisa_game_hub/word_finder/main_page_intro.dart';
import '../main.dart';
import 'data_helper.dart';
import 'database_helper.dart';
import 'game_widget.dart';
import 'helper.dart';

class MainPage extends StatefulWidget {
  const MainPage(this.level, this.listPuzzle, this.index, {super.key});

  final int level;
  final List<List<String>> listPuzzle; // data of category
  final int index; // index in list category

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<List<AWord>> allWords = [];
  List<Color> colorList = [];
  int puzzleIndex = 0;
  late List<int>? data = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.index; i++) {
      puzzleIndex = puzzleIndex + totalCategory[i].length;
    }
    _getDataLocal();
  }

  void _getDataLocal() async {
    final List<String> keys = [];
    int count = 0;
    // get index of package
    for (int i = 0; i < totalCategory[widget.index].length; i++) {
      count = puzzleIndex + 1 + i;
      keys.add(count.toString());
      print("le anh tuan $count");
    }
    data = await Helper.getListData(keys);
    print("le anh tuan ${data?.length} ${data?.last}");
  }

  bool _checkLock(int index) {
    if (index == 0) {
      return true;
    }
    if (data!.length > index) {
      print("data $index ${data?[index - 1]}");
      if (data?[index - 1] == 1) {
        return true;
      }
    }
    return false;
  }

  void getHeightWidth(context) {
    deviceWidth = MediaQuery.of(context).size.width;
  }

  int getMaxLength(List<AWord> words) {
    int max = 6;
    words.forEach((element) {
      if (max < element.word.length) {
        max = element.word.length;
      }
    });
    return max;
  }

  void _navigateGamePlay(
    BuildContext context,
    int index,
    int numberPuzzle,
  ) async {
    if (!_checkLock(index)) {
      return;
    }

    /// navigate to MainPageIntro
    print("navigate to game play $index");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPageIntro()),
    );

    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => GameWidget(
    //           category: "",
    //           words: allWords[index],
    //           numberCol: getMaxLength(allWords[index]) + 1,
    //           numberPuzzle: numberPuzzle)),
    // ).then((value) => {_getDataLocal(), setState(() {})});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getHeightWidth(context);
    return FutureBuilder(
      future: _initializeDatabase(widget.level, widget.listPuzzle),
      // function where you call your api
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Scaffold(
              appBar: AppBar(
                actions: [],
                backgroundColor: Colors.deepPurple,
                elevation: 0,
                title: const Text(
                  "Select A Puzzle",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0F2027), // Màu bắt đầu (xanh đen đậm)
                          Color(0xFF2C5364), // Màu kết thúc (xanh navy đậm)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: widget.listPuzzle.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              _navigateGamePlay(
                                context,
                                index,
                                puzzleIndex + index + 1,
                              );
                            },
                            hoverColor: Colors.blue,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xFF2C5364),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Puzzle ${puzzleIndex + index + 1}",
                                          style: const TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            const Text("   "),
                                            _checkLock(index)
                                                ? const SizedBox()
                                                : const Icon(
                                                    Icons.lock,
                                                    color: Colors.white70,
                                                  ),
                                            const Text("   "),
                                            const Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            const Icon(
                                              Icons.workspace_premium,
                                              color: Colors.white70,
                                            ),
                                            Text(
                                              allWords[index].length
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Text("   "),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }

  Future _initializeDatabase(int level, List<List<String>> listPuzzle) async {
    colorList.add(Colors.deepOrange[400]!);
    colorList.add(Colors.orangeAccent[400]!);
    colorList.add(Colors.purpleAccent[400]!);
    colorList.add(Colors.redAccent[400]!);
    colorList.add(Colors.lightGreen[900]!);
    colorList.add(Colors.indigoAccent);
    colorList.add(Colors.redAccent[400]!);

    final List<ACategory> list = [];
    final List<List<String>> listCategoryTemp = listPuzzle;
    final List<String> catsTemp = cats;

    for (int i = 0; i < listCategoryTemp.length; i++) {
      list.add(ACategory(catsTemp[i]));
    }
    // categories = list;
    for (int i = 0; i < listCategoryTemp.length; i++) {
      List<AWord> listWord = [];
      for (int j = 0; j < listCategoryTemp[i].length; j++) {
        print(listCategoryTemp[i][j].toString());
        listWord.add(AWord(catsTemp[i], listCategoryTemp[i][j].toString()));
      }
      allWords.add(listWord);
    }
  }
}
