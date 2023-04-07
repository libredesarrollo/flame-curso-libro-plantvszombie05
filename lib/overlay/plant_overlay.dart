import 'package:flutter/material.dart';

import 'package:plantvszombie05/main.dart';
import 'package:plantvszombie05/components/plants/plant_component.dart' as pc;

class PlantOverlay extends StatefulWidget {
  final MyGame game;
  const PlantOverlay({super.key, required this.game});

  @override
  State<PlantOverlay> createState() => _PlantOverlayState();
}

class _PlantOverlayState extends State<PlantOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Plant(
              game: widget.game,
              selected: widget.game.plantSelected == pc.Plants.peashooter,
              plant: pc.Plants.peashooter,
              imageAsset: 'assets/images/peashooter.png',
            ),
            const SizedBox(
              width: 5,
            ),
            _Plant(
              game: widget.game,
              duration: const Duration(seconds: 4),
              selected: widget.game.plantSelected == pc.Plants.cactus,
              plant: pc.Plants.cactus,
              imageAsset: 'assets/images/cactus.png',
            ),
          ],
        )
      ]),
    );
  }
}

class _Plant extends StatefulWidget {
  final MyGame game;
  final pc.Plants plant;
  final bool selected;
  final String imageAsset;
  final Duration duration;

  const _Plant(
      {super.key,
      required this.game,
      this.duration = const Duration(seconds: 2),
      required this.plant,
      required this.imageAsset,
      required this.selected});

  @override
  State<_Plant> createState() => __PlantState();
}

class __PlantState extends State<_Plant> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        widget.game.plantsAddedInMap[widget.plant.index] = false;
        _controller.reset();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.game.plantsAddedInMap[widget.plant.index]) {
      _controller.forward();
    }

    return Opacity(
      opacity: pc.PlantCost.cost(widget.plant) <= widget.game.suns ? 1 : 0.5,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: widget.selected ? 5 : 0, color: Colors.blueGrey)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: () {
                widget.game.setPlantSelected(widget.plant);
                //_controller.forward();
              },
              child: Image.asset(
                widget.imageAsset,
                width: 50,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: 60,
                  height: 55 * _controller.value,
                  color: const Color.fromARGB(125, 255, 255, 255),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
