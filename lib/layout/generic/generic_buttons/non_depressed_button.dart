import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';

class NonDepressedButton extends StatelessWidget {
  const NonDepressedButton({super.key, required this.child, this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: menuBackgroundColor,
          border: Border(
            top: BorderSide(color: defaultButtonLightBorderColor, width: 1.5),
            left: BorderSide(color: defaultButtonLightBorderColor, width: 1.5),
            right: BorderSide(color: defaultButtonDarkBorderColor, width: 1.5),
            bottom: BorderSide(color: defaultButtonDarkBorderColor, width: 1.5),
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    ),
  );
}
