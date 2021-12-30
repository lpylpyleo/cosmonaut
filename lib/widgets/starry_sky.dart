import 'dart:math';

import 'package:cosmonaut/core/styles.dart';
import 'package:flutter/material.dart';

class StarrySky extends StatefulWidget {
  final Widget? child;
  const StarrySky({Key? key, this.child}) : super(key: key);

  @override
  _StarrySkyState createState() => _StarrySkyState();
}

class _StarrySkyState extends State<StarrySky> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarrySkyPainter(timelapse: controller, density: 3e-4),
      child: widget.child,
    );
  }
}

class Star {
  Point position;
  double phase;

  Star(this.position, this.phase);
}

class StarrySkyPainter extends CustomPainter {
  final AnimationController timelapse;

  /// Stars per pixel. Must be less than 1.
  /// density = count / size
  final double density;

  List<Star>? stars;

  static const initialSize = 1.0;

  StarrySkyPainter({
    required this.timelapse,
    required this.density,
  })  : assert(density < 1 && density > 0),
        super(repaint: timelapse);

  final starPaint = Paint()
    ..color = AppPalette.gold
    ..style = PaintingStyle.fill;

  final skyPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    canvas.drawRect(Offset.zero & size, skyPaint);
    if (stars == null) {
      final rand = Random();
      stars = List.generate(
        (width * height * density).ceil(),
        (index) => Star(Point(rand.nextDouble(), rand.nextDouble()), rand.nextDouble()),
      );
    }
    for (final star in stars!) {
      canvas.drawCircle(
        Offset(width * star.position.x, height * star.position.y),
        initialSize * (star.phase + timelapse.value - 1).abs(),
        starPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarrySkyPainter oldDelegate) {
    return oldDelegate.timelapse != timelapse || oldDelegate.density != density;
  }
}
