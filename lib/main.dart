import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:plantvszombie05/components/plants/cactus_component.dart';
import 'package:plantvszombie05/components/plants/peashooter_component.dart';
import 'package:plantvszombie05/components/plants/plant_component.dart';
import 'package:plantvszombie05/components/plants/sun_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_cone_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_door_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';
import 'package:plantvszombie05/map/tile_map_component.dart';
import 'package:plantvszombie05/overlay/option_overlay.dart';
import 'package:plantvszombie05/overlay/plant_overlay.dart';
import 'package:plantvszombie05/overlay/sun_overlay.dart';

class MyGame extends FlameGame
    with HasCollisionDetection, HasTappables /*TapDetector*/ {
  late TileMapComponent background;

  double elapsepTime = 0;
  double elapsepTimeSun = 0;
  int zombieI = 0;
  int suns = 50;
  Plants plantSelected = Plants.peashooter;
  // Plants? plantAddedInMap; // null
  final List<bool> plantsAddedInMap = [false, false];

  bool resetGame = false;

  reset() {
    resetGame = true;
    Timer(const Duration(milliseconds: 300), () {
      init();
    });
  }

  init() {
    zombieI = 0;
    suns = 50;
    resetGame = false;
    _refreshOverlayPlant();
    _refreshOverlaySun();
  }

  @override
  void onLoad() {
    background = TileMapComponent(game: this);
    add(background);

    // add(ZombieConeComponent(position: Vector2(1200,48)));
    // add(ZombieDoorComponent(position: Vector2(1200,96)));

    super.onLoad();
  }

  bool addPlant(Vector2 position, Vector2 sizeSeed) {
    late PlantComponent p;

    // if (plantAddedInMap != null) {
    if (plantsAddedInMap[plantSelected.index]) {
      // no agregar la planta seleccionada ya que, esta bloqueada
      return false;
    }

    if (!removeSuns(PlantCost.cost(plantSelected))) {
      return false;
    }

    //bloquear planta
    plantsAddedInMap[plantSelected.index] = true;

    if (plantSelected == Plants.peashooter) {
      p = PeashooterComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
    } else {
      p = CactusComponent(sizeMap: background.tiledMap.size)
        ..position = Vector2(position.x, position.y);
    }

    var fac = sizeSeed.y / p.size.y;
    p.size *= fac;
    add(p);

    return true;
  }

  setPlantSelected(Plants plant) {
    plantSelected = plant;
    _refreshOverlayPlant();
  }

  _refreshOverlayPlant() {
    overlays.remove('Plant');
    overlays.add('Plant');
  }

  _refreshOverlaySun() {
    overlays.remove('Sun');
    overlays.add('Sun');
  }

  addSuns(int sun) {
    suns += sun;
    _refreshOverlaySun();
  }

  bool removeSuns(int sun) {
    if (suns - sun >= 0) {
      suns -= sun;
      _refreshOverlaySun();
      return true;
    }

    return false;
  }

  @override
  Color backgroundColor() {
    super.backgroundColor();

    return Colors.purple;
  }

  @override
  void update(double dt) {
    if (elapsepTimeSun > 2) {
      elapsepTimeSun = 0;
      add(SunComponent(game: this, mapSize: background.tiledMap.size));
    }

    elapsepTimeSun += dt;

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
  runApp(GameWidget(
    game: MyGame(),
    overlayBuilderMap: {
      'Plant': (context, MyGame game) {
        return PlantOverlay(game: game);
      },
      'Sun': (context, MyGame game) {
        return SunOverlay(game: game);
      },
      'Option': (context, MyGame game) {
        return OptionOverlay(game: game);
      }
    },
    initialActiveOverlays: const ['Plant', 'Sun', 'Option'],
  ));
}
