import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(4),
    child: Row(
      children: <Widget>[
        IconButton(
          icon: const Image(
            image: AssetImage('assets/icons/minimize_button.png'),
            semanticLabel: 'Minimize Button',
            width: 24,
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        IconButton(
          icon: const Image(
            image: AssetImage('assets/icons/fullscreen_button.png'),
            semanticLabel: 'Fullscreen Button',
            width: 24,
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 3),
        IconButton(
          icon: const Image(
            image: AssetImage('assets/icons/close_button.png'),
            semanticLabel: 'Close Button',
            width: 24,
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    ),
  );
}
