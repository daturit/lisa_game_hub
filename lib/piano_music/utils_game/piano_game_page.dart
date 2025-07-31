import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../core_tiles/app_data.dart';
import '../piano_game/line.dart';
import '../piano_game/line_divider.dart';
import '../piano_game/note.dart';
import '../utils_game/map_vertical_example.dart';
import '../utils_game/music_model.dart';
import 'constants.dart';
import 'helper_save_data.dart';

const int maxFailedLoadAttempts = 3;

class PianoGamePage extends StatefulWidget {
  const PianoGamePage(this.data, {Key? key}) : super(key: key);

  final MusicModel data;

  @override
  State<PianoGamePage> createState() => _PianoGamePageState();
}

class _PianoGamePageState extends State<PianoGamePage>
    with TickerProviderStateMixin {
  late AssetsAudioPlayer advancedPlayer;
  List<Note> notes = [];
  late AnimationController animationController;
  int currentNoteIndex = 0;
  int points = 0;
  int selectedTheme = 0;
  bool hasStarted = false;
  bool isPlaying = true;
  String mp3Uri = "";
  final audios = <Audio>[];

  @override
  void initState() {
    super.initState();
    notes = ConstantsHelper.initNotes();
    audios.add(Audio(
      'assets/musics/${widget.data.price}',
      playSpeed: 1.0,
    ));
    advancedPlayer = AssetsAudioPlayer.newPlayer();
    openPlayer();

    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: ConstantsHelper.timeNote));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        if (currentNoteIndex > 1 &&
            notes[currentNoteIndex].state != NoteState.tapped) {
          //game over
          setState(() {
            advancedPlayer.stop();
            isPlaying = false;
            notes[currentNoteIndex].state = NoteState.missed;
          });
          animationController.reverse().then((_) => _showFinishDialog());
        } else if (currentNoteIndex == notes.length - 5) {
          //song finished
          _showFinishDialog();
          advancedPlayer.stop();
        } else {
          setState(() => ++currentNoteIndex);
          animationController.forward(from: 0);
          advancedPlayer.play();
        }
      }
    });
  }

  void openPlayer() async {
    await advancedPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
              "assets/image2048/${AppData.themeList[selectedTheme % AppData.themeList.length]}",
              fit: BoxFit.cover),
          !hasStarted
              ? Positioned(
                  bottom: 170, right: 20, child: _buildMusicBtn(context))
              : Container(),
          Row(
            children: <Widget>[
              _drawLine(0),
              LineDivider(),
              _drawLine(1),
              LineDivider(),
              _drawLine(2),
              LineDivider(),
              _drawLine(3),
            ],
          ),
          _drawPoints(),
          !hasStarted
              ? Positioned(top: 50, left: 10, child: _buildStar())
              : Container(),
          !hasStarted
              ? Positioned(bottom: 30, child: _buildThemeIcon(context))
              : Container(),
          Positioned(
              top: 50,
              right: 20,
              child: InkWell(
                  onTap: () {
                   Navigator.pop(context);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.white70,
                      size: 40,
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget _buildThemeIcon(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          color: Colors.white60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: AppData.tilesList.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  if (globalPoint > 100) {
                    globalPoint = globalPoint - 100;
                    HelperSaveData.saveData(
                        ModelUnlock(key: "point", value: globalPoint));
                    selectedTheme = index;
                    setState(() {});
                  } else if (index < 8) {
                    selectedTheme = index;
                    setState(() {});
                  } else {
                    _showDialogSelectedTheme(0);
                  }
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/image2048/${AppData.tilesList[index % AppData.tilesList.length]}"),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: selectedTheme == index ? 5 : 0,
                        color: Colors.amber),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.only(left: 15),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: Text(
            widget.data.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildMusicBtn(BuildContext context) {
    return InkWell(
        onTap: () {
          // _showInterstitialAd();
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) {
              return const FractionallySizedBox(
                heightFactor: 0.8,
                child: MapVerticalPianoGame(),
              );
            },
          );
        },
        child: Container(
          height: 60,
          width: 60,
          child: const Icon(Icons.library_music, color: Colors.white, size: 60),
        ));
  }

  Widget _buildStar() {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
              height: 40,
              width: 40,
              child: Icon(Icons.star, size: 30, color: Colors.amber)),
          Text(
            "$globalPoint",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _restart() {
    setState(() {
      hasStarted = false;
      isPlaying = true;
      notes = ConstantsHelper.initNotes();
      points = 0;
      currentNoteIndex = 0;
    });
    animationController.reset();
  }

  void _showFinishDialog() {
    if (points > highScore) {
      highScore = points;
      HelperSaveData.saveData(ModelUnlock(key: "highScore", value: highScore));
    }
    globalPoint += points;
    HelperSaveData.saveData(ModelUnlock(key: "point", value: globalPoint));
    _showDialogNew(points);
  }

  void _showDialogNew(int point) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      title: point > 200 ? 'Congratulations' : "Try Again!",
      desc: point > 200
          ? 'Congratulations, you achieved $point points'
          : "Try again now, you get $point star.",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      btnOkOnPress: () {
        _restart();
      },
    ).show();
  }

  void _showDialogSelectedTheme(int point) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      title: "GET POINT!",
      desc: " You need 100 point to open CAT. Play game now and get point.",
      buttonsTextStyle: const TextStyle(color: Colors.black),
      btnOkOnPress: () {},
    ).show();
  }

  void _onTap(Note note) {
    bool areAllPreviousTapped = notes
        .sublist(1, note.orderNumber)
        .every((n) => n.state == NoteState.tapped);
    if (areAllPreviousTapped) {
      if (!hasStarted) {
        setState(() => hasStarted = true);
        animationController.forward();
      }
      setState(() {
        note.state = NoteState.tapped;
        ++points;
      });
    }
  }

  _drawLine(int lineNumber) {
    return Expanded(
      child: Line(
        indexTheme: selectedTheme,
        lineNumber: lineNumber,
        currentNotes: notes.sublist(currentNoteIndex, currentNoteIndex + 5),
        onTileTap: _onTap,
        animation: animationController,
      ),
    );
  }

  _drawPoints() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Text(
          "$points",
          style: const TextStyle(
              color: Colors.white, fontSize: 80, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
