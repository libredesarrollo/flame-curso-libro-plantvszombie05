import 'package:flame/collisions.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/plants/plant_component.dart';
import 'package:plantvszombie05/components/zombies/zombie_component.dart';

import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class CactusComponent extends PlantComponent {
  CactusComponent({required sizeMap}) : super(sizeMap) {
    spriteSheetWidth = 39;
    spriteSheetHeight = 37;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  @override
  void onLoad() async {
    final spriteImage = await Flame.images.load('PlantCactus.png');
    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 4, sizeX: 6, stepTime: .2);
    shootAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 4, step: 2, sizeX: 6, stepTime: .8, loop: false);
    shoot('PlantCactusProjectile.png', Vector2(spriteSheetWidth, 12));

    animation = idleAnimation;
    body = RectangleHitbox(
        size: Vector2(spriteSheetWidth, spriteSheetHeight - alignZombie))
      ..collisionType = CollisionType.active;
    add(body);

    super.onLoad();
  }
}
