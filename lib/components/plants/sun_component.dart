import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';
import 'package:plantvszombie05/main.dart';

import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class SunComponent extends SpriteAnimationComponent with Tappable {
  SunComponent({required this.game, required this.mapSize}) : super() {
    debugMode = true;
    size = Vector2(circleWidth, circleHeight);
  }

  MyGame game;
  Vector2 mapSize;

  static const int circleSpeed = 50;
  final int limitX = 80;
  static const double circleWidth = 26, circleHeight = 26;
  double countSin = 0;

  Random random = Random();

  final ShapeHitbox hitbox = CircleHitbox();

  @override
  FutureOr<void> onLoad() async {
    var posX = random.nextDouble() * mapSize.x - circleWidth;

    if (posX < limitX) {
      posX += limitX;
    } else if (posX > mapSize.x - limitX) {
      posX -= limitX;
    }

    position = Vector2(posX, -circleHeight);

    final spriteImage = await Flame.images.load('Sun.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage, srcSize: Vector2(circleWidth, circleHeight));

    animation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 2, sizeX: 2, stepTime: .8);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.resetGame) {
      removeFromParent();
    }

    countSin += 0.05;

    // position.y += circleSpeed * dt;
    position += Vector2(sin(countSin) * 60 * dt, circleSpeed * dt);
    if (position.y > mapSize.y) {
      removeFromParent();
    }

    super.update(dt);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    removeFromParent();
    game.addSuns(5);
    return false;
  }
}
