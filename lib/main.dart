import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:plantvszombie05/components/plants/cactus_component.dart';
import 'package:plantvszombie05/components/plants/peashooter_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_cone_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_door_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';
import 'package:plantvszombie05/map/tile_map_component.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasTappables /*TapDetector*/ {
  late TileMapComponent background;

  double elapsepTime = 0;
  int zombieI = 0;

  @override
  void onLoad() {
    background = TileMapComponent(game: this);
    add(background);

    // add(ZombieConeComponent(position: Vector2(1200,48)));
    // add(ZombieDoorComponent(position: Vector2(1200,96)));

    super.onLoad();
  }

  bool addPlant(Vector2 position, Vector2 sizeSeed) {
    // add(PeashooterComponent());
    // add(CaptusComponent()..position = Vector2(position.dx, position.dy));

    if (Random().nextInt(3) <= 1) {
      var p = CactusComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
      var fac = sizeSeed.y / p.size.y;
      p.size *= fac;
      add(p);
    } else {
      var p = PeashooterComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
      var fac = sizeSeed.y / p.size.y;
      p.size *= fac;
      add(p);
    }

    return true;
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();

    return Colors.purple;
  }

  @override
  void update(double dt) {
    if (elapsepTime > 3.0) {
      if (zombieI < enemiesMap1.length) {
        if (enemiesMap1[zombieI].typeEnemy == TypeEnemy.zombie1) {
          add(ZombieConeComponent(
              position: Vector2(background.tiledMap.size.x,
                  enemiesMap1[zombieI].position - alignZombie)));
        } else {
          add(ZombieDoorComponent(
              position: Vector2(background.tiledMap.size.x,
                  enemiesMap1[zombieI].position - alignZombie)));
        }
        zombieI++;
      }
      elapsepTime = 0;
    }
    elapsepTime += dt;

    super.update(dt);
  }

  // @override
  // void onTapDown(TapDownInfo info) {
  //   addPlant(info.raw.localPosition);
  //   super.onTapDown(info);
  // }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
