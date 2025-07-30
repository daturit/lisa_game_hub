import 'package:flutter/material.dart';
import 'package:lisa_game_hub/2048_game/screens/game_screen.dart';
import 'package:lisa_game_hub/2048_game/screens/loading_screen.dart';
import 'package:lisa_game_hub/2048_game/settings.dart';
import 'package:lisa_game_hub/2048_game/theme_manager.dart';
import 'package:provider/provider.dart';

import 'core_2048_game.dart';

class Game2048Screen extends StatefulWidget {
  const Game2048Screen({Key? key}) : super(key: key);

  @override
  State<Game2048Screen> createState() => _Game2048ScreenState();
}

class _Game2048ScreenState extends State<Game2048Screen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<GameSetting>(create: (ctx) => GameSetting()),
        ChangeNotifierProxyProvider<GameSetting, Game>(
          update: (ctx, setting, game) => Game(setting),
          create: (ctx) => Game(null),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return Scaffold(
            body: FutureBuilder(
              future: Provider.of<GameSetting>(context, listen: false).fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return const GameScreen(title: '2048');
                } else {
                  return const LoadingScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
