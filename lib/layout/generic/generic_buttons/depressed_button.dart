import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';

class DepressedButton extends StatelessWidget {
  const DepressedButton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: menuBackgroundColor,
          border: Border(
            top: BorderSide(color: defaultButtonDarkBorderColor, width: 1.5),
            left: BorderSide(color: defaultButtonDarkBorderColor, width: 1.5),
            right: BorderSide(color: defaultButtonLightBorderColor, width: 1.5),
            bottom: BorderSide(color: defaultButtonLightBorderColor, width: 1.5),
          ),
        ),
        alignment: Alignment.center,
        child: child,
      );
}
