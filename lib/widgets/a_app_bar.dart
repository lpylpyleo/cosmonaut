import 'dart:ui';

import 'package:cosmonaut/widgets/a_text.dart';
import 'package:flutter/material.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar({
    Key? key,
    required this.title,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: backgroundColor ?? Colors.grey.shade200.withOpacity(0.01),
              ),
            ),
          ),
        ),
        SafeArea(
          child: SizedBox(
            height: preferredSize.height,
            child: Center(child: AText(title)),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
