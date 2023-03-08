import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:plantvszombie05/main.dart';

class SeedComponent extends PositionComponent with Tappable {
  // 48 / 25  = 2
  MyGame game;
  bool sown = false;
  SeedComponent({required size, required position, required this.game})
      : super(size: size, position: position) {
    debugMode = false;

    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    //info.raw.localPosition
    if (!sown) {
      if (game.addPlant(position, size)) {
        sown = true;
      }
    }
    return super.onTapDown(info);
  }
}
