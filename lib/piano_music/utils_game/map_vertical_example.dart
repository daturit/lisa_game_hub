import 'package:flutter/material.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';
import 'package:lisa_game_hub/piano_music/utils_game/piano_game_page.dart';
import '../../../main.dart';
import '../core_tiles/app_data.dart';

class MapVerticalPianoGame extends StatefulWidget {
  const MapVerticalPianoGame({Key? key}) : super(key: key);

  @override
  State<MapVerticalPianoGame> createState() => _MapVerticalPianoGameState();
}

class _MapVerticalPianoGameState extends State<MapVerticalPianoGame> {
  // InterstitialAd? _interstitialAd;
  // int _numInterstitialLoadAttempts = 0;
  //
  // static const AdRequest request = AdRequest(
  //   keywords: <String>['a', 'b'],
  //   contentUrl: '',
  //   nonPersonalizedAds: true,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.deepPurple.withOpacity(0.8),
        elevation: 0,
        title: const Text(
          "Select A Music",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        child: GameLevelsScrollingMap.scrollable(
          imageUrl: "assets/drawable/map_vertical.png",
          direction: Axis.vertical,
          reverseScrolling: true,
          pointsPositionDeltaX: 5,
          pointsPositionDeltaY: 5,
          svgUrl: 'assets/svg/map_vertical.svg',
          points: points,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    fillTestData();
    // _createInterstitialAd();
  }

  List<PointModel> points = [];

  void fillTestData() {
    for (int i = 0; i < 35; i++) {
      points.add(PointModel(35, testWidget(i)));
    }
  }

  Widget testWidget(int order) {
    return InkWell(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/drawable/map_vertical_point.png",
            fit: BoxFit.fitWidth,
            width: 50,
          ),
          // const Icon(Icons.lock, color: Colors.red, size: 30),
          Text(
            "$order",
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
      onTap: () {
        if (isRemoveAds == false && order > 1) {
          // _showInterstitialAd();
        }
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (_, __, ___) => PianoGamePage(
              AppData.furnitureList[order % AppData.furnitureList.length],
            ),
          ),
        );

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       content: Text("Point $order"),
        //       actions: <Widget>[
        //         ElevatedButton(
        //           child: const Text("OK"),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      },
    );
  }
}
