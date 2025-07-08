import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/generic/generic_buttons/non_depressed_button.dart';
import 'package:personal_website/routing/pw_router.dart';

class TaskBarStartButton extends StatelessWidget {
  const TaskBarStartButton({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(2),
    child: NonDepressedButton(
      child: const Padding(
        padding: EdgeInsets.only(right: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(3),
              child: Image(
                image: AssetImage('assets/icons/win95_icon.png'),
                semanticLabel: 'Windows 95 Start Icon',
                width: 26,
              ),
            ),
            Text(
              'Home',
              style: TextStyle(
                color: menuTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onPressed: () => GoRouter.of(context).go(routeHome),
    ),
  );
}
