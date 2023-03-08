import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:plantvszombie05/main.dart';
import 'package:plantvszombie05/map/seed_component.dart';

class TileMapComponent extends PositionComponent {
  late TiledComponent tiledMap;
  MyGame game;

  TileMapComponent({required this.game});

  @override
  FutureOr<void> onLoad() async {

    tiledMap = await TiledComponent.load('map.tmx', Vector2.all(48));
    add(tiledMap);

    final objSeed = tiledMap.tileMap.getLayer<ObjectGroup>('seed');

    for (var obj in objSeed!.objects) {
      add(SeedComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y),
          game: game
          ));
    }

    return super.onLoad();
  }
}
