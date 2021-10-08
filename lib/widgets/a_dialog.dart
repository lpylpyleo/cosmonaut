import 'package:cosmonaut/core/styles.dart';
import 'package:cosmonaut/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'a_text.dart';

class ADialog extends StatelessWidget {
  final String? title;
  final String? message;

  const ADialog({
    Key? key,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[500],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 32, 8, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) AText(title!, fontSize: 16, textAlign: TextAlign.center),
            if (message != null) const SizedBox(height: 32),
            if (message != null) AText(message!, fontSize: 14, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
                backgroundColor: MaterialStateColor.resolveWith((states) => Style.gold),
              ),
              onPressed: () => Get.back(),
              child: AText(S.current.confirm),
            ),
          ],
        ),
      ),
    );
  }
}
