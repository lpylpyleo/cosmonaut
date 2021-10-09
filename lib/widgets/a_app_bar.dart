import 'dart:ui';

import 'package:cosmonaut/widgets/a_text.dart';
import 'package:flutter/material.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.action,
  }) : super(key: key);

  final String title;
  final Color? backgroundColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    const actionWidth = 80.0;
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: backgroundColor ?? Color(0xff555555).withOpacity(0.05),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SafeArea(
            child: SizedBox(
              height: preferredSize.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: actionWidth),
                  Center(
                    child: AText(
                      title,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: actionWidth,
                    child: Center(child: action),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
