import 'package:flutter/material.dart';

class ShimmerRect extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerRect({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey,
    );
  }
}
