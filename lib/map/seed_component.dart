import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:plantvszombie05/main.dart';

class SeedComponent extends PositionComponent with TapCallbacks {
  // 48 / 25  = 2
  MyGame game;
  bool sown = false;
  bool busy = false;
  SeedComponent({required size, required position, required this.game})
      : super(size: size, position: position) {
    debugMode = true;

    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void onTapDown(TapDownEvent event) {
    //info.raw.localPosition
    if (!sown && !busy) {
      if (game.addPlant(position, size)) {
        sown = true;
      }
    }
    super.onTapDown(event);
  }
}
