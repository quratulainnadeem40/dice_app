import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Cube3DDiceWidget extends StatefulWidget {
  final int value;
  final bool isRolling;

  const Cube3DDiceWidget({
    Key? key,
    required this.value,
    required this.isRolling,
  }) : super(key: key);

  @override
  State<Cube3DDiceWidget> createState() => _Cube3DDiceWidgetState();
}

class _Cube3DDiceWidgetState extends State<Cube3DDiceWidget> with SingleTickerProviderStateMixin {
  late Object diceObject;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Create 3D Mesh Cube
    diceObject = Object(
      name: 'cube',
      scale: Vector3(2.0, 2.0, 2.0),
      backfaceCulling: true,
    );
    
//     // Mesh Box creation
//     diceObject.mesh = Mesh(
//       vertices: [
//         // Front
//         Vector3(-1, -1, 1), Vector3(1, -1, 1), Vector3(1, 1, 1), Vector3(-1, 1, 1),
//         // Back
//         Vector3(1, -1, -1), Vector3(-1, -1, -1), Vector3(-1, 1, -1), Vector3(1, 1, -1),
//       ],
//       // 
//       indices: Uint16List.fromList([
//   0, 1, 2, 0, 2, 3, // Front
//   4, 5, 6, 4, 6, 7, // Back
//   5, 0, 3, 5, 3, 6, // Left
//   1, 4, 7, 1, 7, 2, // Right
//   3, 2, 7, 3, 7, 6, // Top
//   5, 4, 1, 5, 1, 0, // Bottom
// ]),
//       colors: List.filled(24, Colors.purpleAccent),
//     );
// Mesh Box creation
diceObject.mesh = Mesh(
  vertices: [
    // Front
    Vector3(-1, -1, 1), Vector3(1, -1, 1), Vector3(1, 1, 1), Vector3(-1, 1, 1),
    // Back
    Vector3(1, -1, -1), Vector3(-1, -1, -1), Vector3(-1, 1, -1), Vector3(1, 1, -1),
  ],
  indices: [
    Polygon(0, 1, 2), Polygon(0, 2, 3), // Front
    Polygon(4, 5, 6), Polygon(4, 6, 7), // Back
    Polygon(5, 0, 3), Polygon(5, 3, 6), // Left
    Polygon(1, 4, 7), Polygon(1, 7, 2), // Right
    Polygon(3, 2, 7), Polygon(3, 7, 6), // Top
    Polygon(5, 4, 1), Polygon(5, 1, 0), // Bottom
  ],
  colors: List.filled(24, Colors.purpleAccent),
);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.addListener(() {
      if (widget.isRolling) {
        diceObject.rotation.x += 15;
        diceObject.rotation.y += 20;
        diceObject.rotation.z += 10;
        diceObject.updateTransform();
      }
    });

    if (widget.isRolling) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant Cube3DDiceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRolling && !_animationController.isAnimating) {
      _animationController.repeat();
    } else if (!widget.isRolling && _animationController.isAnimating) {
      _animationController.stop();
      _setFinalFaceAngle(widget.value);
    }
  }

  // Final value par exact 3D angle set karne ke liye
  void _setFinalFaceAngle(int value) {
    switch (value) {
      case 1:
        diceObject.rotation.setValues(0, 0, 0);
        break;
      case 2:
        diceObject.rotation.setValues(0, 180, 0);
        break;
      case 3:
        diceObject.rotation.setValues(0, 90, 0);
        break;
      case 4:
        diceObject.rotation.setValues(0, -90, 0);
        break;
      case 5:
        diceObject.rotation.setValues(-90, 0, 0);
        break;
      case 6:
        diceObject.rotation.setValues(90, 0, 0);
        break;
    }
    diceObject.updateTransform();
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(diceObject);
          scene.camera.zoom = 10;
          scene.light.setColor(Colors.white, 0.8, 0.8, 0.8);
        },
      ),
    );
  }
}