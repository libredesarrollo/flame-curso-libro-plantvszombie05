import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

// import 'package:audioplayers/audioplayers.dart';

import 'package:flame_audio/flame_audio.dart';

import 'package:plantvszombie05/components/plants/plant_component.dart';
import 'package:plantvszombie05/components/plants/projectile_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';
import 'package:plantvszombie05/main.dart';
import 'package:plantvszombie05/map/seed_component.dart';

const double alignZombie = 10;

class ZombieComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<MyGame> {
  late SpriteAnimation walkingAnimation, walkingHurtAnimation, eatingAnimation;

  bool isAttacking = false;
  bool attack = false;
  double elapsedTimeAtacking = 0;

  int life = 100;
  int damage = 20;
  String audioWalkSound = 'zombie1.wav';

  double speed = 15;
  double spriteSheetWidth = 128, spriteSheetHeight = 128;
  late RectangleHitbox body;

  Vector2 positionCopy = Vector2(0, 0);

  late AudioPlayer audioWalk;

  ZombieComponent(position) : super(position: position) {
    debugMode = true;
    scale = Vector2.all(1);
    positionCopy = position;
  }

  @override
  FutureOr<void> onLoad() {
    countEnemiesInMap++;
    FlameAudio.loop(audioWalkSound, volume: .4)
        .then((audioPlayer) => audioWalk = audioPlayer);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (game.resetGame) {
      removeFromParent();
    }

    if (!isAttacking) {
      position.add(Vector2(-dt * speed, 0));
      positionCopy.add(Vector2(-dt * speed, 0));
    }

    if (elapsedTimeAtacking > 2) {
      elapsedTimeAtacking = 0;
      attack = true;
    }
    elapsedTimeAtacking += dt;

    if (position.x <= -size.x) {
      // el zombie ya no esta en el mapa
      // zombie GANO
      removeFromParent();
      _setChannel(false);
    }

    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlantComponent) {
      animation = eatingAnimation;
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is SeedComponent) {
      other.busy = true;
      _setChannel(true);
    }

    if (other is ProjectileComponent) {
      other.removeFromParent();
      life -= other.damage;
      if (life <= 50) {
        animation = walkingHurtAnimation;
      }
      if (life <= 0) {
        removeFromParent();
      }
    }

    // if (other is PeashooterComponent || other is CactusComponent) {
    if (other is PlantComponent) {
      isAttacking = true;
      if (attack) {
        other.life -= damage;
        if (other.life <= 0) {
          other.removeFromParent();
        }

        attack = false;
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is SeedComponent) {
      other.busy = false;
      other.sown = false;
    }

    if (other is PlantComponent) {
      isAttacking = false;
      attack = false;

      if (life <= 50) {
        animation = walkingHurtAnimation;
      } else {
        animation = walkingAnimation;
      }
    }
  }

  @override
  void onGameResize(Vector2 size) {
    scale = Vector2.all(game.factScale);
    position = positionCopy * game.factScale;

    super.onGameResize(size);
  }

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   if (other is SeedComponent) {
  //     _setChannel(false);
  //   }
  //   super.onCollisionEnd(other);
  // }

  _setChannel(bool value) {
    if (positionCopy.y + alignZombie == 48) {
      enemiesInChannel[0] = value;
    } else if (positionCopy.y + alignZombie == 96) {
      enemiesInChannel[1] = value;
    } else if (positionCopy.y + alignZombie == 144) {
      enemiesInChannel[2] = value;
    } else if (positionCopy.y + alignZombie == 192) {
      enemiesInChannel[3] = value;
    } else if (positionCopy.y + alignZombie == 240) {
      enemiesInChannel[4] = value;
    } else if (positionCopy.y + alignZombie == 288) {
      enemiesInChannel[5] = value;
    } else if (positionCopy.y + alignZombie == 336) {
      enemiesInChannel[6] = value;
    }
    // print(enemiesInChannel.toString());
  }

  @override
  void onRemove() {
    _setChannel(false);
    countEnemiesInMap--;
    audioWalk.dispose();
    super.onRemove();
  }
}
