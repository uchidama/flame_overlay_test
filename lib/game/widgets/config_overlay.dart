import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../app/common.dart';
import 'widgets.dart';
import '../game_app.dart';

class ConfigOverlay extends StatefulWidget {
  const ConfigOverlay(this.game, {super.key});

  final Game game;

  @override
  State<ConfigOverlay> createState() => ConfigOverlayState();
}

class ConfigOverlayState extends State<ConfigOverlay> {
  bool isPaused = false;
  // Mobile Support: Add isMobile boolean
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  //RotateDirection? rotateDirection = RotateDirection.right;

  @override
  Widget build(BuildContext context) {
    GameApp game = widget.game as GameApp;
    RotateDirection? rotateDirection = game.getRotateDirection();

    return LayoutBuilder(builder: (context, constraints) {
      final characterWidth = constraints.maxWidth / 5;

      final TextStyle titleStyle = (constraints.maxWidth > 830)
          ? Theme.of(context).textTheme.displayLarge!
          : Theme.of(context).textTheme.displaySmall!;

      // 760 is the smallest height the browser can have until the
      // layout is too large to fit.
      final bool screenHeightIsSmall = constraints.maxHeight < 760;

      return Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Flame Overlay Test Config',
                    style: titleStyle.copyWith(
                      height: .8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ListTile(
                    title: Text("右回転"),
                    leading: Radio<RotateDirection>(
                      value: RotateDirection.right,
                      groupValue: rotateDirection,
                      onChanged: (RotateDirection? value) {
                        setState(() {
                          rotateDirection = value;
                          game.setRotateDirection(value!);
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("左回転"),
                    leading: Radio<RotateDirection>(
                      value: RotateDirection.left,
                      groupValue: rotateDirection,
                      onChanged: (RotateDirection? value) {
                        setState(() {
                          rotateDirection = value;
                          game.setRotateDirection(value!);
                        });
                      },
                    ),
                  ),
                  const WhiteSpace(),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        game.setRotateDirection(rotateDirection!);
                        game.startGame();
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(100, 50),
                        ),
                        textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.titleLarge),
                      ),
                      child: const Text('Start'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
