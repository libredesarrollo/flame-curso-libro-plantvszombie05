import 'package:flame/collisions.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/plants/plant_component.dart';
import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class PeashooterComponent extends PlantComponent {
  PeashooterComponent({required sizeMap}) : super(sizeMap) {
    spriteSheetWidth = 27;
    spriteSheetHeight = 31;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  @override
  void onLoad() async {
    // life = 10000;

    final spriteImage = await Flame.images.load('PlantPeashooter.png');
    final spriteSheetIdle = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));
    final spriteSheetShoot = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth - 2, spriteSheetHeight));

    idleAnimation = spriteSheetIdle.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 8, sizeX: 8, stepTime: .2);
    shootAnimation = spriteSheetShoot.createAnimationByLimit(
        xInit: 1, yInit: 0, step: 3, sizeX: 8, stepTime: .8); // lopppppXXXXX
    animation = idleAnimation;

    shootAnimationTicker = shootAnimation.createTicker();

    shoot('PlantPeashooterProjectile.png', Vector2(27, 2));

    body =
        RectangleHitbox(/*size: Vector2(spriteSheetWidth, spriteSheetHeight)*/);
    add(body);

    super.onLoad();
  }
}
