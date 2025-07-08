import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/taskbar/taskbar_start_button.dart';

class TaskbarSmallScreen extends StatelessWidget {
  const TaskbarSmallScreen({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 40,
    decoration: const BoxDecoration(
      color: menuBackgroundColor,
      border: Border(
        top: BorderSide(color: defaultButtonLightBorderColor, width: 1.5),
      ),
    ),
    child: const TaskBarStartButton(),
  );
}
