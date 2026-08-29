
import 'dart:math' as math;

import 'package:flutter/material.dart';

class Real3DDiceWidget extends StatefulWidget {
  final double size;
  final bool isRolling;
  final int value;
  final Color baseColor;

  const Real3DDiceWidget({
    super.key,
    required this.size,
    required this.isRolling,
    required this.value,
    this.baseColor = const Color(0xFF7C4DFF),
  });

  @override
  State<Real3DDiceWidget> createState() => _Real3DDiceWidgetState();
}

class _Real3DDiceWidgetState extends State<Real3DDiceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    if (widget.isRolling) {
      _animController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant Real3DDiceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isRolling && !_animController.isAnimating) {
      _animController.repeat();
    } else if (!widget.isRolling && _animController.isAnimating) {
      _animController.stop();

      _animController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final double progress =
            _animController.value * math.pi * 2;

        final double rotX = widget.isRolling
            ? progress * 2.8
            : 0.48;

        final double rotY = widget.isRolling
            ? progress * 3.6
            : -0.58;

        final double rotZ = widget.isRolling
            ? progress * 1.7
            : 0.08;

        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: Realistic3DDicePainter(
            rotX: rotX,
            rotY: rotY,
            rotZ: rotZ,
            value: widget.value,
            baseColor: widget.baseColor,
          ),
        );
      },
    );
  }
}

class Realistic3DDicePainter extends CustomPainter {
  final double rotX;
  final double rotY;
  final double rotZ;
  final int value;
  final Color baseColor;

  Realistic3DDicePainter({
    required this.rotX,
    required this.rotY,
    required this.rotZ,
    required this.value,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double center = size.width / 2;
    final double cubeSize = size.width * 0.32;

    // ------------------------------------------------------------
    // 1. 3D CUBE VERTICES
    // ------------------------------------------------------------

    final List<List<double>> vertices = [
      [-1, -1, -1],
      [1, -1, -1],
      [1, 1, -1],
      [-1, 1, -1],
      [-1, -1, 1],
      [1, -1, 1],
      [1, 1, 1],
      [-1, 1, 1],
    ];

    // Back, Front, Bottom, Top, Left, Right
    final List<List<int>> faces = [
      [0, 1, 2, 3],
      [4, 5, 6, 7],
      [0, 1, 5, 4],
      [2, 3, 7, 6],
      [0, 3, 7, 4],
      [1, 2, 6, 5],
    ];

    // Dice values assigned to each face.
    final List<int> faceValues = [
      1,
      6,
      2,
      5,
      3,
      4,
    ];

    // ------------------------------------------------------------
    // 2. ROTATE + PROJECT VERTICES
    // ------------------------------------------------------------

    final List<Offset> projected = [];
    final List<double> transformedZ = [];

    for (final vertex in vertices) {
      double x = vertex[0];
      double y = vertex[1];
      double z = vertex[2];

      // Rotation X
      final double y1 =
          y * math.cos(rotX) - z * math.sin(rotX);

      final double z1 =
          y * math.sin(rotX) + z * math.cos(rotX);

      // Rotation Y
      final double x2 =
          x * math.cos(rotY) + z1 * math.sin(rotY);

      final double z2 =
          -x * math.sin(rotY) + z1 * math.cos(rotY);

      // Rotation Z
      final double x3 =
          x2 * math.cos(rotZ) - y1 * math.sin(rotZ);

      final double y3 =
          x2 * math.sin(rotZ) + y1 * math.cos(rotZ);

      // Perspective
      const double fov = 4.2;

      final double perspective =
          fov / (fov + z2);

      projected.add(
        Offset(
          center + x3 * cubeSize * perspective,
          center + y3 * cubeSize * perspective,
        ),
      );

      transformedZ.add(z2);
    }

    // ------------------------------------------------------------
    // 3. SOFT GROUND SHADOW
    // ------------------------------------------------------------

    final Paint shadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withOpacity(0.42),
          Colors.black.withOpacity(0.18),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCenter(
          center: Offset(
            center,
            center + size.height * 0.32,
          ),
          width: size.width * 0.72,
          height: size.height * 0.22,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          center,
          center + size.height * 0.32,
        ),
        width: size.width * 0.72,
        height: size.height * 0.22,
      ),
      shadowPaint,
    );

    // ------------------------------------------------------------
    // 4. CALCULATE FACE DEPTH
    // ------------------------------------------------------------

    final List<Map<String, dynamic>> drawOrder = [];

    for (int i = 0; i < faces.length; i++) {
      final face = faces[i];

      final double avgZ =
          (transformedZ[face[0]] +
                  transformedZ[face[1]] +
                  transformedZ[face[2]] +
                  transformedZ[face[3]]) /
              4;

      drawOrder.add({
        'index': i,
        'z': avgZ,
        'value': faceValues[i],
      });
    }

    drawOrder.sort(
      (a, b) => b['z'].compareTo(a['z']),
    );

    // ------------------------------------------------------------
    // 5. DRAW VISIBLE FACES
    // ------------------------------------------------------------

    for (final faceData in drawOrder) {
      final int faceIndex = faceData['index'];
      final List<int> face = faces[faceIndex];

      final Path path = Path()
        ..moveTo(
          projected[face[0]].dx,
          projected[face[0]].dy,
        )
        ..lineTo(
          projected[face[1]].dx,
          projected[face[1]].dy,
        )
        ..lineTo(
          projected[face[2]].dx,
          projected[face[2]].dy,
        )
        ..lineTo(
          projected[face[3]].dx,
          projected[face[3]].dy,
        )
        ..close();

      // ----------------------------------------------------------
      // FACE GRADIENT
      // ----------------------------------------------------------

      final Color darkColor =
          Color.lerp(
            baseColor,
            Colors.black,
            0.38,
          )!;

      final Color lightColor =
          Color.lerp(
            baseColor,
            Colors.white,
            0.28,
          )!;

      final Paint facePaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            lightColor,
            baseColor,
            darkColor,
          ],
          stops: const [
            0.0,
            0.48,
            1.0,
          ],
        ).createShader(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
        );

      canvas.drawPath(path, facePaint);

      // ----------------------------------------------------------
      // GLOSSY EDGE
      // ----------------------------------------------------------

      final Paint borderPaint = Paint()
        ..color = Colors.white.withOpacity(0.42)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..strokeJoin = StrokeJoin.round;

      canvas.drawPath(path, borderPaint);

      // ----------------------------------------------------------
      // FACE PIPS
      // ----------------------------------------------------------

      final int faceValue =
          faceData['value'] as int;

      _drawPips(
        canvas,
        projected,
        face,
        faceValue,
        size,
      );
    }

    // ------------------------------------------------------------
    // 6. TOP GLOSS HIGHLIGHT
    // ------------------------------------------------------------

    final Paint glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(0.20),
          Colors.white.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            center - size.width * 0.12,
            center - size.height * 0.18,
          ),
          radius: size.width * 0.32,
        ),
      );

    canvas.drawCircle(
      Offset(
        center - size.width * 0.12,
        center - size.height * 0.18,
      ),
      size.width * 0.32,
      glowPaint,
    );
  }

  // ==============================================================
  // PIPS
  // ==============================================================

  void _drawPips(
    Canvas canvas,
    List<Offset> projected,
    List<int> face,
    int number,
    Size size,
  ) {
    final Offset p0 = projected[face[0]];
    final Offset p1 = projected[face[1]];
    final Offset p2 = projected[face[2]];
    final Offset p3 = projected[face[3]];

    // Bilinear interpolation on the cube face.
    Offset point(double u, double v) {
      final Offset top =
          Offset.lerp(p0, p1, u)!;

      final Offset bottom =
          Offset.lerp(p3, p2, u)!;

      return Offset.lerp(top, bottom, v)!;
    }

    final double pipRadius =
        size.width * 0.032;

    final List<List<double>> positions =
        _pipPositions(number);

    for (final position in positions) {
      final Offset pipPosition =
          point(position[0], position[1]);

      // Recess shadow
      final Paint pipShadow = Paint()
        ..color = Colors.black.withOpacity(0.55);

      canvas.drawCircle(
        pipPosition.translate(
          1.5,
          2.0,
        ),
        pipRadius * 1.05,
        pipShadow,
      );

      // Actual pip
      final Paint pipPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.black.withOpacity(0.98),
            Colors.black.withOpacity(0.72),
          ],
        ).createShader(
          Rect.fromCircle(
            center: pipPosition,
            radius: pipRadius,
          ),
        );

      canvas.drawCircle(
        pipPosition,
        pipRadius,
        pipPaint,
      );

      // Small highlight
      final Paint pipHighlight = Paint()
        ..color = Colors.white.withOpacity(0.10);

      canvas.drawCircle(
        pipPosition.translate(
          -pipRadius * 0.25,
          -pipRadius * 0.25,
        ),
        pipRadius * 0.28,
        pipHighlight,
      );
    }
  }

  List<List<double>> _pipPositions(int value) {
    const double left = 0.24;
    const double center = 0.50;
    const double right = 0.76;

    const double top = 0.24;
    const double middle = 0.50;
    const double bottom = 0.76;

    switch (value) {
      case 1:
        return [
          [center, middle],
        ];

      case 2:
        return [
          [left, top],
          [right, bottom],
        ];

      case 3:
        return [
          [left, top],
          [center, middle],
          [right, bottom],
        ];

      case 4:
        return [
          [left, top],
          [right, top],
          [left, bottom],
          [right, bottom],
        ];

      case 5:
        return [
          [left, top],
          [right, top],
          [center, middle],
          [left, bottom],
          [right, bottom],
        ];

      case 6:
        return [
          [left, top],
          [left, middle],
          [left, bottom],
          [right, top],
          [right, middle],
          [right, bottom],
        ];

      default:
        return [
          [center, middle],
        ];
    }
  }

  @override
  bool shouldRepaint(
    covariant Realistic3DDicePainter oldDelegate,
  ) {
    return oldDelegate.rotX != rotX ||
        oldDelegate.rotY != rotY ||
        oldDelegate.rotZ != rotZ ||
        oldDelegate.value != value ||
        oldDelegate.baseColor != baseColor;
  }
}

