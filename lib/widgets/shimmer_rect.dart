import 'package:flutter/material.dart';

class ShimmerRect extends StatefulWidget {
  final double width;
  final double height;

  const ShimmerRect({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ShimmerRectState createState() => _ShimmerRectState();
}

class _ShimmerRectState extends State<ShimmerRect> with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      lowerBound: 0.2,
      upperBound: 0.8,
      duration: const Duration(milliseconds: 1500),
    );
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              transform: const GradientRotation(0.6),
              stops: [0, controller.value, 1],
              colors: [
                Colors.grey[500]!,
                Colors.grey[300]!,
                Colors.grey[500]!,
              ],
            ),
          ),
        );
      },
    );
  }
}
