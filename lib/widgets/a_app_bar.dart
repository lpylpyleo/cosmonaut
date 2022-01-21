import 'dart:ui';

import 'package:cosmonaut/widgets/a_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar({
    Key? key,
    required this.title,
    this.backgroundColor,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final String title;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    const actionWidth = 80.0;
    final route = ModalRoute.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: backgroundColor ?? const Color(0xff555555).withOpacity(0.3),
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
                    Container(
                      width: actionWidth,
                      alignment: Alignment.centerLeft,
                      child: leading ?? ((route?.canPop ?? false) ? const BackButton() : Container()),
                    ),
                    Center(
                      child: AText(
                        title,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: actionWidth,
                      child: Center(child: trailing),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
