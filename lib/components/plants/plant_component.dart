import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:plantvszombie05/components/plants/projectile_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';

enum State { idle, shoot }

class PlantComponent extends SpriteAnimationComponent with CollisionCallbacks {
  double spriteSheetWidth = 50, spriteSheetHeight = 50;

  int life = 100;
  int damage = 10;

  late SpriteAnimation idleAnimation, shootAnimation;
  late RectangleHitbox body;

  State state = State.idle;
  Vector2 sizeMap;

  PlantComponent(this.sizeMap) : super() {
    debugMode = true;
    scale = Vector2.all(1);
  }

  @override
  void update(double dt) {
    if (enemiesInChannel[(position.y / sizeTileMap).toInt() - 1]) {
      if (state != State.shoot) {
        animation = shootAnimation;
      }
      state = State.shoot;
    } else {
      if (state != State.idle) {
        animation = idleAnimation;
      }
      state = State.idle;
    }

    super.update(dt);
  }

  void shoot(String sprite, Vector2 position){
    shootAnimation.onComplete = () async {
      add(ProjectileComponent(projectile: await Sprite.load(sprite), sizeMap: sizeMap, position: position, damage: damage));
      shootAnimation.reset();
    };
  }

}
