import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/zombies/zombie_component.dart';
import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class ZombieFemaleComponent extends ZombieComponent {
  ZombieFemaleComponent({required position}) : super(position) {
    spriteSheetWidth = 521;
    spriteSheetHeight = 576;
    size = Vector2(37, 56);
  }

  @override
  FutureOr<void> onLoad() async {
    final spriteImage = await Flame.images.load('ZombieFemale.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // walkingAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 5, step: 6, sizeX: 19, stepTime: .2);
    eatingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 8, sizeX: 3, stepTime: .2);
    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 3, step: 10, sizeX: 3, stepTime: .2);
    walkingHurtAnimation = spriteSheet.createAnimationByLimit(
        xInit: 6, yInit: 0, step: 9, sizeX: 3, stepTime: .2);

    animation = walkingAnimation;

    body = RectangleHitbox(
        size: Vector2(size.x, size.y - alignZombie),
        position: Vector2(0, alignZombie))
      ..collisionType = CollisionType.active;
    add(body);

    return super.onLoad();
  }
}
