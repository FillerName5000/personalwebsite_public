import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';

class FileExplorerWindowBorder extends StatelessWidget {
  const FileExplorerWindowBorder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(color: windowDarkFirstExternalBorderColor, width: 3),
        left: BorderSide(color: windowDarkFirstExternalBorderColor, width: 3),
        right: BorderSide(color: defaultButtonLightBorderColor, width: 3),
        bottom: BorderSide(color: defaultButtonLightBorderColor, width: 3),
      ),
    ),
    child: child,
  );
}
