/**
 * overlay参考
 * https://codelabs.developers.google.com/codelabs/flutter-flame-game?hl=ja#9
 */

import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

import 'game/game_app.dart';
import 'game/util/util.dart';
import 'game/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
  /*
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyGame',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.audiowideTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Doodle Dash'),
    );
  }
}

final MyGame game = MyGame();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return GestureDetector(
            onTapDown: (TapDownDetails details) {
              // タップされた座標を取得
              // FlameGameでタップを処理
              //game.onTapDown(event);
              game.onTap(details);
            },
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 800,
                minWidth: 550,
              ),
              child: GameWidget(
                game: game,
                overlayBuilderMap: <String,
                    Widget Function(BuildContext, Game)>{
                  'gameOverlay': (context, game) => GameOverlay(game),
                  //'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                  //'gameOverOverlay': (context, game) => GameOverOverlay(game),
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
