import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:plantvszombie05/main.dart';

class SeedComponent extends PositionComponent with TapCallbacks {
  // 48 / 25  = 2
  MyGame game;
  bool sown = false;
  bool busy = false;

  Vector2 positionOriginal = Vector2(0, 0);

  SeedComponent({required size, required position, required this.game})
      : super(size: size, position: position) {
    debugMode = true;
    positionOriginal = position;
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void onTapDown(TapDownEvent event) {
    //info.raw.localPosition
    if (!sown && !busy) {
      if (game.addPlant(positionOriginal, size)) {
        sown = true;
      }
    }
    super.onTapDown(event);
  }

  @override
  void onGameResize(Vector2 size) {
    scale = Vector2.all(game.factScale);
    position = positionOriginal * game.factScale;
    super.onGameResize(size);
  }
}
