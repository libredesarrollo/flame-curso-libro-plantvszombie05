import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:plantvszombie05/components/plants/projectile_component.dart';
import 'package:plantvszombie05/helpers/enemies/movements.dart';
import 'package:plantvszombie05/main.dart';

enum State { idle, shoot }

enum Plants { peashooter, cactus }

class PlantCost {
  static const peashooter = 20;
  static const cactus = 30;

  static int cost(Plants plant) {
    switch (plant) {
      case Plants.peashooter:
        return peashooter;
      case Plants.cactus:
        return cactus;
    }
  }
}

class PlantComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<MyGame> {
  double spriteSheetWidth = 50;
  double spriteSheetHeight = 50;

  late SpriteAnimationTicker shootAnimationTicker;

  Vector2 positionOriginal = Vector2.all(0);

  int life = 100;
  int damage = 10;

  late SpriteAnimation idleAnimation;
  late SpriteAnimation shootAnimation;
  late RectangleHitbox body;

  State state = State.idle;
  Vector2 sizeMap;

  PlantComponent(this.sizeMap, position) : super(position: position) {
    debugMode = true;
    positionOriginal = position;
    scale = Vector2.all(1);
  }

  @override
  void update(double dt) {
    if (game.resetGame) {
      removeFromParent();
    }

    if (enemiesInChannel[(positionOriginal.y / sizeTileMap).toInt() - 1]) {
      if (state != State.shoot) {
        // shootAnimationTicker = shootAnimation.createTicker();
        animation = shootAnimation;
      }
      state = State.shoot;
    } else {
      if (state != State.idle) {
        animation = idleAnimation;
      }
      state = State.idle;
    }

    shootAnimationTicker.update(dt);

    super.update(dt);
  }

  void shoot(String sprite, Vector2 position) {
    shootAnimationTicker.onFrame = (value) async {
      if (shootAnimationTicker.isLastFrame) {
        if (state == State.shoot) {
          print("********DISPARANDO");
          add(ProjectileComponent(
              projectile: await Sprite.load(sprite),
              sizeMap: sizeMap,
              position: position,
              damage: damage));
          shootAnimationTicker.reset();
        }
      }
    };

    // shootAnimation.onComplete = () async {
    //   add(ProjectileComponent(
    //       projectile: await Sprite.load(sprite),
    //       sizeMap: sizeMap,
    //       position: position,
    //       damage: damage));
    //   // shootAnimation.reset();
    // };
  }

  @override
  void onGameResize(Vector2 size) {
    scale = Vector2.all(game.factScale);
    position = positionOriginal * game.factScale;

    super.onGameResize(size);
  }
}
