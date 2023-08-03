enum TypeEnemy { zombie1, zombie2 }

const sizeTileMap = 48;

class BehaviorEnemy {
  int position;
  TypeEnemy typeEnemy;

  BehaviorEnemy({required this.typeEnemy, required this.position});
}

const channelsMap1 = 7;
List<BehaviorEnemy> enemiesMap1 = [
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 1 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 2 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 3 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 4 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 5 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie1, position: 6 * sizeTileMap),
  BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 1 * sizeTileMap),
  // BehaviorEnemy(typeEnemy: TypeEnemy.zombie2, position: 7 * sizeTileMap),
];

List<bool> enemiesInChannel = List.generate(channelsMap1, (index) => false);

// la cantidad de enemigos en el mapa
int countEnemiesInMap = 0;
