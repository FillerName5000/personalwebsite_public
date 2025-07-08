import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';

class CrtContainer extends StatelessWidget {
  const CrtContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: AspectRatio(
        aspectRatio: 1.33,
        child: ColoredBox(
          color: Colors.white,
          child: Center(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: crtBorderColor, width: 75),
                  left: BorderSide(color: crtBorderColor, width: 30),
                  right: BorderSide(color: crtBorderColor, width: 30),
                  bottom: BorderSide(color: crtBorderColor, width: 95),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 75,
                  left: 30,
                  right: 30,
                  bottom: 95,
                ),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: crtBorderDarkColor, width: 30),
                      left: BorderSide(color: crtBorderMediumColor, width: 75),
                      right: BorderSide(color: crtBorderMediumColor, width: 75),
                      bottom: BorderSide(color: crtBorderLightColor, width: 30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 75,
                      right: 75,
                      bottom: 30,
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
