import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'app/common.dart';

RotateDirection rotateDirection = RotateDirection.left;

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
class GameApp extends FlameGame {
  //with TapCallbacks {
  GameApp({super.children});

  ValueNotifier<int> score = ValueNotifier(0);

  @override
  Future<void> onLoad() async {
    add(Square(size / 2));
    score.value = 1;
    //overlays.add('gameOverlay');
    overlays.add('configOverlay');
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  /*
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (!event.handled) {
      final touchPoint = event.canvasPosition;
      add(Square(touchPoint));
    }
  }
  */

  void onTap(TapDownDetails details) {
    //final Vector2 position = Vector2.fromOffset(details.localPosition);
    add(Square(Vector2(details.localPosition.dx, details.localPosition.dy)));
    score.value++;
  }

  void togglePauseState() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }

  void setRotateDirection(RotateDirection direction) {
    rotateDirection = direction;
  }

  void setConfig() {
    overlays.remove('gameOverlay');
    overlays.add('configOverlay');
  }

  RotateDirection? getRotateDirection() {
    return rotateDirection;
  }

  void startGame() {
    //initializeGameStart();
    //gameManager.state = GameState.playing;
    overlays.remove('configOverlay');
    overlays.add('gameOverlay');
  }
}

class Square extends RectangleComponent with TapCallbacks {
  static const speed = 3;
  static const squareSize = 128.0;
  static const indicatorSize = 6.0;

  static final Paint red = BasicPalette.red.paint();
  static final Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(squareSize),
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    super.update(dt);

    switch (rotateDirection) {
      case RotateDirection.left:
        angle -= speed * dt;
        break;
      case RotateDirection.right:
        angle += speed * dt;
        break;
    }
    //angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      RectangleComponent(
        size: Vector2.all(indicatorSize),
        paint: blue,
      ),
    );
    add(
      RectangleComponent(
        position: size / 2,
        size: Vector2.all(indicatorSize),
        anchor: Anchor.center,
        paint: red,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    event.handled = true;
  }
}
