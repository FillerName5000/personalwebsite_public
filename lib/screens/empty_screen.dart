import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/routing/pw_router.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: IconButton(
        icon: const Image(
          image: AssetImage('assets/icons/fullscreen_button.png'),
          semanticLabel: 'Fullscreen Button',
          width: 24,
        ),
        onPressed: () async => context.push(routeHome),
      ),
    ),
  );
}
