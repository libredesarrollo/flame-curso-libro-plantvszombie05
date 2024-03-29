import 'package:flame/collisions.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/plants/plant_component.dart';
import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class PeashooterComponent extends PlantComponent {
  PeashooterComponent({required sizeMap, required position})
      : super(sizeMap, position) {
    spriteSheetWidth = 433;
    spriteSheetHeight = 433;
    size = Vector2(30, 30);
  }

  @override
  void onLoad() async {
    // life = 10000;

    final spriteImage = await Flame.images.load('PlantPeashooter.png');
    final spriteSheetIdle = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    idleAnimation = spriteSheetIdle.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 3, sizeX: 3, stepTime: .2);
    shootAnimation = spriteSheetIdle.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 3, sizeX: 3, stepTime: .8);

    animation = idleAnimation;

    shootAnimationTicker = shootAnimation.createTicker();

    shoot('PlantPeashooterProjectile.png', Vector2(27, 20));

    body =
        RectangleHitbox(/*size: Vector2(spriteSheetWidth, spriteSheetHeight)*/);
    add(body);

    super.onLoad();
  }
}
