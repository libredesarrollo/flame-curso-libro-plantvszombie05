import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';

import 'package:plantvszombie05/main.dart';

class BackgroundComponent extends PositionComponent
    with HasGameReference<MyGame>, DragCallbacks {
  late RectangleComponent _rectangleComponent;

  @override
  FutureOr<void> onLoad() {
    size = game.size;
    // scale = Vector2.all(1);

    _rectangleComponent = RectangleComponent(
        position: Vector2.all(0),
        size: game.size,
        paint: Paint()..color = Colors.purple);

    add(_rectangleComponent);
  }

  @override
  void onGameResize(Vector2 size) {
    // print(size.toSize());
    _rectangleComponent.size = size;
    this.size = size;
    super.onGameResize(size);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final camera =
        game.firstChild<CameraComponent>()!; // gameRef.cameraComponent;
    // camera.moveBy(event.delta);
    camera.viewfinder.position += event.delta / camera.viewfinder.zoom;

    position = camera.viewfinder.position;

    super.onDragUpdate(event);
  }

  // @override
  // void onDragStart(DragStartEvent event) {
  //   print("event.canvasPosition" + event.canvasPosition.toString());
  //   print("event.devicePosition" + event.devicePosition.toString());
  //   print("event.localPosition" + event.localPosition.toString());
  //   print("event.parentPosition" + event.parentPosition.toString());

  //   super.onDragStart(event);
  // }

  // @override
  // void onDragEnd(DragEndEvent event) {
  //   print("DragEndEvent");
  //   super.onDragEnd(event);
  // }
}
