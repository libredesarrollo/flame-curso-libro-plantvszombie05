import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/zombies/zombie_component.dart';
import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class ZombieMaleComponent extends ZombieComponent {
  ZombieMaleComponent({required position}) : super(position) {
    // spriteSheetWidth = 27.6;
    // spriteSheetHeight = 55.5;
    spriteSheetWidth = 430;
    spriteSheetHeight = 519;
    size = Vector2(37, 56);
    speed = 15;
    // auidoWalkSound = 'zombie2.wav';
  }

  @override
  FutureOr<void> onLoad() async {
    // life = 250;
    // damage = 15;

    final spriteImage = await Flame.images.load('ZombieMale.png');

    final spriteSheet = SpriteSheet(
        image: spriteImage,
        srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    walkingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 8, sizeX: 4, stepTime: .2);
    walkingHurtAnimation = spriteSheet.createAnimationByLimit(
        xInit: 2, yInit: 0, step: 8, sizeX: 4, stepTime: .2);
    eatingAnimation = spriteSheet.createAnimationByLimit(
        xInit: 4, yInit: 0, step: 8, sizeX: 4, stepTime: .2);

    animation = walkingAnimation;

    body = RectangleHitbox()..collisionType = CollisionType.active;
    add(body);

    return super.onLoad();
  }
}
