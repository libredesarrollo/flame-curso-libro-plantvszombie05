import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ProjectileComponent extends SpriteComponent {
  final Sprite projectile;
  final double speed;
  final Vector2 sizeMap;
  int damage;

  ProjectileComponent({
    required this.projectile,
    required this.sizeMap,
    required position,
    this.damage = 10,
    this.speed = 120,
  }) : super(size: Vector2.all(20), sprite: projectile, position: position) {
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.add(Vector2(dt * speed, 0));

    if (position.x >= sizeMap.x) {
      removeFromParent();
    }

    super.update(dt);
  }
}
