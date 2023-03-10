import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/zombies/zombie_component.dart';
import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class ZombieDoorComponent extends ZombieComponent {
  ZombieDoorComponent({required position}) : super(position) {
    spriteSheetWidth = 29.2;
    spriteSheetHeight = 52;
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
  }

  @override
  FutureOr<void> onLoad() async {
    final spriteImage = await Flame.images.load('ZombieDoor.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    // walkingAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 5, step: 6, sizeX: 19, stepTime: .2);
    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 6, sizeX: 19, stepTime: .2);
    walkingHurtAnimation = spriteSheet.createAnimationByLimit(
        xInit: 2, yInit: 4, step: 6, sizeX: 19, stepTime: .2);
    eatingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 6, sizeX: 19, stepTime: .2);

    animation = walkingAnimation;

    body = RectangleHitbox(
        size: Vector2(spriteSheetWidth, spriteSheetHeight - alignZombie))
      ..collisionType = CollisionType.active;
    add(body);

    return super.onLoad();
  }
}
