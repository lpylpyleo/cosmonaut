import 'package:flutter/material.dart';

class ShimmerWrapper extends StatelessWidget {
  final bool shouldShimmer;
  final Widget shimmer;
  final Widget child;

  const ShimmerWrapper({
    Key? key,
    required this.shouldShimmer,
    required this.shimmer,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      child: shouldShimmer ? shimmer : child,
    );
  }
}
