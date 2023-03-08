import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

import 'package:plantvszombie05/components/zombies/zombie_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';
import 'package:plantvszombie05/utils/create_animation_by_limit.dart';

class ZombieConeComponent extends ZombieComponent {
  ZombieConeComponent({required position}) : super(position) {
    spriteSheetWidth = 27.6;
    spriteSheetHeight = 55.5;
    size = Vector2(spriteSheetWidth,spriteSheetHeight);
    speed = 15;
  }

  @override
  FutureOr<void> onLoad() async{

    // life = 250;
    // damage = 15;
    
    final spriteImage = await Flame.images.load('ZombieCone.png');

    final spriteSheet = SpriteSheet(image: spriteImage
    , srcSize: Vector2(spriteSheetWidth,spriteSheetHeight));

    walkingAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 5, step: 6, sizeX: 19, stepTime: .2);
    walkingHurtAnimation = spriteSheet.createAnimationByLimit(xInit: 1, yInit: 5, step: 6, sizeX: 19, stepTime: .2);
    eatingAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 12, step: 6, sizeX: 19, stepTime: .2);

    animation = walkingAnimation;

    body = RectangleHitbox()
      ..collisionType = CollisionType.active;
    add(body);

    return super.onLoad();
  }



}