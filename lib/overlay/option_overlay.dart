import 'package:flutter/material.dart';
import 'package:plantvszombie05/main.dart';

class OptionOverlay extends StatefulWidget {
  final MyGame game;

  const OptionOverlay({super.key, required this.game});

  @override
  State<OptionOverlay> createState() => _OptionOverlayState();
}

class _OptionOverlayState extends State<OptionOverlay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                  child: SizedBox(
                height: 10,
              )),
              GestureDetector(
                onTap: () {
                  widget.game.paused = !widget.game.paused;
                },
                child: Icon(
                  widget.game.paused ? Icons.play_arrow : Icons.pause,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.game.reset();
                },
                child: const Icon(
                  Icons.replay,
                  size: 40,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
