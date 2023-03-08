import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plantvszombie05/components/plants/plant_component.dart';
import 'package:plantvszombie05/components/plants/projectile_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';
import 'package:plantvszombie05/map/seed_component.dart';

const double alignZombie = 20;

class ZombieComponent extends SpriteAnimationComponent with CollisionCallbacks {
  late SpriteAnimation walkingAnimation, walkingHurtAnimation, eatingAnimation;

  bool isAttacking = false;
  bool attack = false;
  double elapsedTimeAtacking = 0;

  int life = 100;
  int damage = 20;

  double speed = 12;
  double spriteSheetWidth = 128, spriteSheetHeight = 128;
  late RectangleHitbox body;

  ZombieComponent(position) : super(position: position) {
    debugMode = true;
    scale = Vector2.all(1);
  }

  @override
  void update(double dt) {
    if (!isAttacking) position.add(Vector2(-dt * speed, 0));

    if (elapsedTimeAtacking > 2) {
      elapsedTimeAtacking = 0;
      attack = true;
    }
    elapsedTimeAtacking += dt;

    if (position.x <= -size.x) {
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

  // @override
  // void onCollisionEnd(PositionComponent other) {
  //   if (other is SeedComponent) {
  //     _setChannel(false);
  //   }
  //   super.onCollisionEnd(other);
  // }

  _setChannel(bool value) {
    if (position.y + alignZombie == 48) {
      enemiesInChannel[0] = value;
    } else if (position.y + alignZombie == 96) {
      enemiesInChannel[1] = value;
    } else if (position.y + alignZombie == 144) {
      enemiesInChannel[2] = value;
    } else if (position.y + alignZombie == 192) {
      enemiesInChannel[3] = value;
    } else if (position.y + alignZombie == 240) {
      enemiesInChannel[4] = value;
    } else if (position.y + alignZombie == 288) {
      enemiesInChannel[5] = value;
    } else if (position.y + alignZombie == 336) {
      enemiesInChannel[6] = value;
    }
    print(enemiesInChannel.toString());
  }
  @override
  void onRemove() {
    _setChannel(false);
    super.onRemove();
  }

}
